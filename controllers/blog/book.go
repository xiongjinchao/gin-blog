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

	c.HTML(http.StatusOK, "book/chapter", gin.H{
		"title":       bookChapter.Title + "-" + config.Setting["app"]["title"],
		"user":        helper.GetUser(c),
		"menu":        helper.GetMenu(),
		"bookChapter": bookChapter,
	})
}
