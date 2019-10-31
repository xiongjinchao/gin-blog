package middleware

import (
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Auth struct{}

func (_ *Auth) CheckAuth() gin.HandlerFunc {
	return func(c *gin.Context) {

		auth := helper.GetUser(c)

		if auth.User.ID <= 0 {
			c.Redirect(http.StatusFound, "/")
			c.Abort()
			return
		}

		c.Next()
	}
}
