package blog

import (
	"fmt"
	"gin-blog/config"
	db "gin-blog/database"
	"gin-blog/helper"
	"gin-blog/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type Article struct{}

// Index handles GET /article route
func (a *Article) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "article/index", gin.H{
		"title": "文章首页",
		"menu":  helper.GetMenu(),
	})
}

// Category handles GET /article/category/:tag route
func (a *Article) Category(c *gin.Context) {

	category := models.ArticleCategory{}
	if err := db.Mysql.Where("tag = ?", c.Param("tag")).First(&category).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	total, size, page := 0, 10, 1
	page, err := strconv.Atoi(c.Query("page"))
	if err != nil {
		page = 1
	}
	if page <= 0 {
		page = 1
	}
	var articles []models.Article

	query := db.Mysql.Model(models.Article{}).
		Select("id,title,cover,category_id,summary,hit,comment,favorite,user_id,created_at").
		Where("audit = 1 and category_id = ?", category.ID)

	query.Count(&total)

	query.Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id desc").Offset((page - 1) * size).Limit(size).Find(&articles)
	(&models.Article{}).SetTags(&articles)

	c.HTML(http.StatusOK, "article/category", gin.H{
		"title":      category.Name + "-" + config.Setting["app"]["title"],
		"menu":       helper.GetMenu(),
		"category":   category,
		"articles":   articles,
		"pagination": (&helper.Pagination{}).Generate(total, size, page, "/article/category/"+c.Param("tag")),
		"image":      config.Setting["domain"]["image"],
	})
}

// Detail handles GET /article/detail/:id route
func (a *Article) Detail(c *gin.Context) {

	id := c.Param("id")
	article := models.Article{}
	if err := db.Mysql.First(&article, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	article.Hit = article.Hit + 1
	if err := db.Mysql.Model(&models.Article{}).Omit("ArticleCategory", "User", "File").Save(&article).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	var tags []models.Tag
	if err := db.Mysql.Model(&models.Tag{}).Where("model = ? and model_id = ?", "article", id).Find(&tags).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	related, err := (&models.Article{}).GetRelatedArticle(article.ID, article.CategoryID)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		related = nil
	}

	recommend, err := (&models.Article{}).GetRelatedArticle(article.ID, article.CategoryID)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		recommend = nil
	}

	c.HTML(http.StatusOK, "article/detail", gin.H{
		"title":     article.Title + "-" + config.Setting["app"]["title"],
		"menu":      helper.GetMenu(),
		"article":   article,
		"tags":      tags,
		"related":   related,
		"recommend": recommend,
		"image":     config.Setting["domain"]["image"],
	})
}
