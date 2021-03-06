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
		"user":  helper.GetUser(c),
		"menu":  helper.GetMenu(),
	})
}

// Category handles GET /article/category/:tag route
func (a *Article) Category(c *gin.Context) {

	var category models.ArticleCategory
	if err := db.Mysql.Where("tag = ?", c.Param("tag")).First(&category).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	categories := helper.GetArticleCategories()
	category.SetParents(&categories, category.Parent, &category.Parents)

	total, size, page := 0, 10, 1
	page, err := strconv.Atoi(c.DefaultQuery("page", "1"))
	if err != nil {
		page = 1
	}
	var articles []models.Article

	query := db.Mysql.Model(models.Article{}).
		Select("id,title,cover,category_id,summary,hit,useful,useless,comment,favorite,user_id,created_at").
		Where("audit = 1 and category_id = ?", category.ID)

	query.Count(&total)
	query.Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id desc").Offset((page - 1) * size).Limit(size).Find(&articles)
	(&models.Article{}).SetTags(&articles)

	recommend, err := helper.GetRecommendArticle(0, category.ID)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	breadcrumb := make([]map[string]string, 0)
	breadcrumb = append(breadcrumb, map[string]string{"label": "首页", "link": "/", "active": ""})
	for _, v := range category.Parents {
		breadcrumb = append(breadcrumb, map[string]string{"label": v.Name, "link": "/article/category/" + v.Tag, "active": ""})
	}
	breadcrumb = append(breadcrumb, map[string]string{"label": category.Name, "link": "/article/category/" + category.Tag, "active": "1"})

	c.HTML(http.StatusOK, "article/category", gin.H{
		"title":      category.Name + "-" + config.Setting["app"]["title"],
		"breadcrumb": breadcrumb,
		"user":       helper.GetUser(c),
		"menu":       helper.GetMenu(),
		"category":   category,
		"articles":   articles,
		"pagination": (&helper.Pagination{}).Generate(total, size, page, "/article/category/"+c.Param("tag")),
		"recommend":  recommend,
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

	(article).SetTag()

	var category models.ArticleCategory
	if err := db.Mysql.Where("id = ?", article.ID).First(&category).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	categories := helper.GetArticleCategories()
	category.SetParents(&categories, category.Parent, &category.Parents)

	related, err := helper.GetRelatedArticle(article.ID, article.CategoryID)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	recommend, err := helper.GetRecommendArticle(article.ID, article.CategoryID)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	breadcrumb := make([]map[string]string, 0)
	breadcrumb = append(breadcrumb, map[string]string{"label": "首页", "link": "/", "active": ""})
	for _, v := range category.Parents {
		breadcrumb = append(breadcrumb, map[string]string{"label": v.Name, "link": "/article/category/" + v.Tag, "active": ""})
	}
	breadcrumb = append(breadcrumb, map[string]string{"label": category.Name, "link": "/article/category/" + category.Tag, "active": ""})
	breadcrumb = append(breadcrumb, map[string]string{"label": article.Title, "link": "/article/detail/" + c.Param("id"), "active": "1"})

	// pagination comments
	total, size, page := 0, 10, 1
	page, err = strconv.Atoi(c.Query("page"))
	if err != nil {
		page = 1
	}
	if page <= 0 {
		page = 1
	}
	var comments []models.Comment

	query := db.Mysql.Model(models.Comment{}).Where("root = 0 and model= 'article' and model_id=?", c.Param("id"))
	query.Count(&total)
	query.Order("id desc").Preload("User").Preload("UserAuth").Offset((page - 1) * size).Limit(size).Find(&comments)

	for i, v := range comments {
		db.Mysql.Model(models.Comment{}).Where("root = ?", v.ID).Preload("User").Preload("UserAuth").Find(&(comments[i].Children))
		for j, c := range comments[i].Children {
			comment := models.Comment{}
			db.Mysql.Model(models.Comment{}).Where("id = ?", c.Parent).Preload("User").Preload("UserAuth").First(&comment)
			comments[i].Children[j].Father = comment
		}
	}

	c.HTML(http.StatusOK, "article/detail", gin.H{
		"title":      article.Title + "-" + config.Setting["app"]["title"],
		"breadcrumb": breadcrumb,
		"user":       helper.GetUser(c),
		"menu":       helper.GetMenu(),
		"article":    article,
		"related":    related,
		"recommend":  recommend,
		"comments":   comments,
		"model":      "article",
		"pagination": (&helper.Pagination{}).Generate(total, size, page, "/article/detail/"+c.Param("id")),
		"image":      config.Setting["domain"]["image"],
	})
}
