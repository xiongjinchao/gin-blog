package blog

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type FriendLink struct{}

// Index handles GET /friend-link route
func (p *FriendLink) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "friend-link/index", gin.H{
		"title": "友情链接",
	})
}
