package blog

import (
	"fmt"
	"gin-blog/helper"
	"gin-blog/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Index(c *gin.Context) {

	// the new note
	note, err := (&models.Article{}).GetNewNote()
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		note = nil
	}

	// the new article
	article, err := (&models.Article{}).GetNewArticle()
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		article = nil
	}

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title":   "Susan's Blog golang 技术笔记",
		"menu":    helper.GetMenu(),
		"note":    note,
		"article": article,
	})
}
