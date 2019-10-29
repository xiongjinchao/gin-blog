package blog

import (
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Page struct{}

// About handles GET /about route
func (p *Page) About(c *gin.Context) {
	c.HTML(http.StatusOK, "page/about", gin.H{
		"title": "关于我们",
		"user":  helper.GetUser(c),
		"menu":  helper.GetMenu(),
	})
}
