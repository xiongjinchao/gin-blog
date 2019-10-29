package blog

import (
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
)

type FriendLink struct{}

// Index handles GET /link-share route
func (p *FriendLink) Index(c *gin.Context) {
	c.HTML(http.StatusOK, "friend-link/index", gin.H{
		"title": "链接分享",
		"user":  helper.GetUser(c),
		"menu":  helper.GetMenu(),
	})
}
