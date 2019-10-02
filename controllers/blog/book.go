package blog

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Book struct{}

// Index handles GET /book route
func (a *Book) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "book/index", gin.H{
		"title": "书籍首页",
	})
}

// Detail handles GET /book/detail/:id route
func (a *Book) Detail(c *gin.Context) {
	c.HTML(http.StatusOK, "book/detail", gin.H{
		"title": "书籍详情页",
	})
}
