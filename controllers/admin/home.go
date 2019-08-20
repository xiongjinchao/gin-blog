package admin

import (
	"fmt"
	db "gin/database"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Dashboard(c *gin.Context) {
	routers, err := db.Redis.Get("routers").Result()
	if err != nil {
		fmt.Println(err)
	}
	println(routers)

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "系统面板",
	})
}