package blog

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Home struct{}

// Index handles GET /admin route
func (h *Home) Index(c *gin.Context) {
	/*
		data, err := db.Redis.Get("menu").Result()
		fmt.Println(data)
		fmt.Println(err)

	*/

	/*
		var menus, data []models.Menu
		data, err := (models.Menu{}).GetCache()
		if err != nil {
			if err := db.Mysql.Model(&models.Menu{}).Find(&menus).Error; err != nil {
				_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
			}
			(&models.Menu{}).SetSort(&menus, 0, &data)
			(&models.Menu{}).SetSpace(&data)
		}
		fmt.Println(data)
	*/

	c.HTML(http.StatusOK, "home/index", gin.H{
		"title": "首页",
	})
}
