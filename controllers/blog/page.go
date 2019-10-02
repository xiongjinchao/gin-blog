package blog

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Page struct{}

// About handles GET /about route
func (p *Page) About(c *gin.Context) {
	c.HTML(http.StatusOK, "page/about", gin.H{
		"title": "关于我们",
	})
}
