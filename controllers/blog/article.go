package blog

import (
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
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
	c.HTML(http.StatusOK, "article/category", gin.H{
		"title": "文章列表页",
		"menu":  helper.GetMenu(),
	})
}

// Detail handles GET /article/detail/:id route
func (a *Article) Detail(c *gin.Context) {
	c.HTML(http.StatusOK, "article/detail", gin.H{
		"title": "文章详情页",
		"menu":  helper.GetMenu(),
	})
}
