package blog

import (
	"fmt"
	db "gin-blog/database"
	"gin-blog/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Index(c *gin.Context) {

	var menus, data []models.Menu
	data, err := (&models.Menu{}).GetCache()
	if err != nil {
		if err := db.Mysql.Model(&models.Menu{}).Find(&menus).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		}
		(&models.Menu{}).SetSort(&menus, 0, &data)
		(&models.Menu{}).SetSpace(&data)
	}

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "Susan's Blog golang 技术笔记",
		"menu":  data,
	})
}
