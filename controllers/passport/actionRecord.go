package passport

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

type ActionRecord struct{}

// Create handles GET /passport/action-record/create route
func (a *ActionRecord) Create(c *gin.Context) {

	c.JSON(http.StatusBadRequest, gin.H{
		"code":    401,
		"message": "auth forbidden",
	})
}
