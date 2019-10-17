package helper

import (
	"fmt"
	db "gin-blog/database"
	"gin-blog/models"
	"github.com/gin-gonic/gin"
)

func GetMenu() []models.Menu {
	var menus, data []models.Menu
	data, err := (&models.Menu{}).GetCache()
	if err != nil {
		if err := db.Mysql.Model(&models.Menu{}).Find(&menus).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		}
		(&models.Menu{}).SetSort(&menus, 0, &data)
		(&models.Menu{}).SetData(&data)
	}

	return data
}
