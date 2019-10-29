package blog

import (
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Course struct{}

// Index handles GET /course route
func (co *Course) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "course/detail", gin.H{
		"title": "教程",
		"user":  helper.GetUser(c),
		"menu":  helper.GetMenu(),
	})
}
