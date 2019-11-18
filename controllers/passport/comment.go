package passport

import (
	db "gin-blog/database"
	"gin-blog/helper"
	"gin-blog/models"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type Comment struct{}

// Create handles GET /passport/comment/create route
func (co *Comment) Create(c *gin.Context) {
	modelID, err := strconv.ParseInt(c.PostForm("model_id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": err.Error(),
		})
		return
	}
	root, err := strconv.ParseInt(c.PostForm("root"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": err.Error(),
		})
		return
	}
	parent, err := strconv.ParseInt(c.PostForm("parent"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": err.Error(),
		})
		return
	}
	auth := helper.GetUser(c)
	comment := models.Comment{
		Model:   c.PostForm("model"),
		ModelID: modelID,
		Content: c.PostForm("content"),
		Root:    root,
		Parent:  parent,
		UserID:  auth.User.ID,
	}

	if err := db.Mysql.Create(&comment).Error; err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": err.Error(),
		})
		return
	}

	total := 0
	db.Mysql.Model(&models.Comment{}).Where("model = ? and model_id = ?", c.PostForm("model"), c.PostForm("model_id")).Count(&total)
	switch c.PostForm("model") {
	case "article":
		db.Mysql.Model(&models.Article{}).Where("id = ?", c.PostForm("model_id")).Update("comment", total)
		break
	case "book":
		db.Mysql.Model(&models.Book{}).Where("id = ?", c.PostForm("model_id")).Update("comment", total)
		break
	case "book_chapter":
		db.Mysql.Model(&models.BookChapter{}).Where("id = ?", c.PostForm("model_id")).Update("comment", total)

		bookChapter := models.BookChapter{}
		db.Mysql.Model(&models.BookChapter{}).Where("id = ?", c.PostForm("model_id")).First(&bookChapter)
		db.Mysql.Model(&models.BookChapter{}).Select("SUM(comment)").Where("book_id = ?", bookChapter.BookID).Pluck("SUM(comment)", &total)
		db.Mysql.Model(&models.Book{}).Where("id = ?", bookChapter.BookID).Update("comment", total)
		break
	case "comment":
		db.Mysql.Model(&models.Comment{}).Where("id = ?", c.PostForm("model_id")).Update("comment", total)
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
		"message": "comment success",
		"data": gin.H{
			"total": total,
		},
	})
}
