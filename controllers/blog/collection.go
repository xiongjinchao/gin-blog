package blog

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Collection struct{}

// Index handles GET /collection route
func (co *Collection) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "page/about", gin.H{
		"title": "我的收藏",
	})
}
