package passport

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type Comment struct{}

// Create handles GET /passport/comment/create route
func (co *Comment) Create(c *gin.Context) {

	c.JSON(http.StatusBadRequest, gin.H{
		"code":    401,
		"message": "auth forbidden",
	})
}
