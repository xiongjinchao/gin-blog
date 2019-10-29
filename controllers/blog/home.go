package blog

import (
	"fmt"
	"gin-blog/config"
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Index(c *gin.Context) {

	// the new note
	note, err := helper.GetNewNote()
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		note = nil
	}

	// the new article
	article, err := helper.GetNewArticle()
	if err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		article = nil
	}

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title":   config.Setting["app"]["title"],
		"user":    helper.GetUser(c),
		"menu":    helper.GetMenu(),
		"note":    note,
		"article": article,
	})
}
