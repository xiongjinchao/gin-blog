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

type Book struct{}

// Index handles GET /book route
func (a *Book) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "book/index", gin.H{
		"title": "书籍首页" + "-" + config.Setting["app"]["title"],
		"user":  helper.GetUser(c),
		"menu":  helper.GetMenu(),
	})
}

// Detail handles GET /book/detail/:tag route
func (a *Book) Detail(c *gin.Context) {

	tag := c.Param("tag")
	book := models.Book{}
	if err := db.Mysql.Where("tag = ?", tag).First(&book).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	bookChapter := models.BookChapter{}
	if err := db.Mysql.Where("book_id = ?", book.ID).Order("id ASC").First(&bookChapter).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	// redirect to the first chapter
	c.Redirect(http.StatusFound, "/book/chapter/"+strconv.FormatInt(bookChapter.ID, 10))
}

// Detail handles GET /book/chapter/:id route
func (a *Book) Chapter(c *gin.Context) {

	id := c.Param("id")
	bookChapter := models.BookChapter{}
	if err := db.Mysql.Preload("Book").First(&bookChapter, id).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

	related, err := helper.GetRelatedBookChapter(bookChapter.ID, bookChapter.BookID)
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}

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

	query := db.Mysql.Model(models.Comment{}).Where("root = 0 and model= 'book-chapter' and model_id=?", c.Param("id"))
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

	c.HTML(http.StatusOK, "book/chapter", gin.H{
		"title":       bookChapter.Title + "-" + config.Setting["app"]["title"],
		"user":        helper.GetUser(c),
		"menu":        helper.GetMenu(),
		"bookChapter": bookChapter,
		"model":       "book_chapter",
		"related":     related,
		"comments":    comments,
		"pagination":  (&helper.Pagination{}).Generate(total, size, page, "/book/chapter/"+c.Param("id")),
	})
}
