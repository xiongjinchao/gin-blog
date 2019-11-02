package passport

import (
	db "gin-blog/database"
	"gin-blog/helper"
	"gin-blog/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type ActionLog struct{}

// Create handles GET /passport/action-record/create route
func (a *ActionLog) Create(c *gin.Context) {
	modelID, err := strconv.ParseInt(c.PostForm("model_id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": err.Error(),
		})
		return
	}
	auth := helper.GetUser(c)

	existed := 0
	db.Mysql.Model(&models.ActionLog{}).Where("model = ? and model_id = ? and action = ? and user_id = ?", c.PostForm("model"), modelID, c.PostForm("action"), auth.User.ID).Count(&existed)
	if existed > 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": "禁止重复操作",
		})
		return
	}

	actionLog := models.ActionLog{
		Model:   c.PostForm("model"),
		ModelID: modelID,
		Action:  c.PostForm("action"),
		UserID:  auth.User.ID,
	}

	if err := db.Mysql.Create(&actionLog).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": err.Error(),
		})
		return
	}
	total := 0
	db.Mysql.Model(&models.ActionLog{}).Where("model = ? and model_id = ? and action = ?", c.PostForm("model"), c.PostForm("model_id"), c.PostForm("action")).Count(&total)
	switch c.PostForm("model") {
	case "article":
		db.Mysql.Model(&models.Article{}).Where("id = ?", c.PostForm("model_id")).Update(c.PostForm("action"), total)
		break
	case "book":
		db.Mysql.Model(&models.Book{}).Where("id = ?", c.PostForm("model_id")).Update(c.PostForm("action"), total)
		break
	case "bookChapter":
		db.Mysql.Model(&models.BookChapter{}).Where("id = ?", c.PostForm("model_id")).Update(c.PostForm("action"), total)
		break
	case "comment":
		db.Mysql.Model(&models.Comment{}).Where("id = ?", c.PostForm("model_id")).Update(c.PostForm("action"), total)
		break
	default:
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": "illegal operation",
		})
		return
	}
	c.JSON(http.StatusCreated, gin.H{
		"code":    200,
		"message": "action success",
		"data": gin.H{
			"total": total,
		},
	})
}
