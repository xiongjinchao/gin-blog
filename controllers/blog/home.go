package blog

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "首页",
	})
}
