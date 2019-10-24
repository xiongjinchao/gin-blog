package controllers

import (
	"fmt"
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Oauth struct{}

// Login handles GET /oauth/login/:type route
func (o *Oauth) Login(c *gin.Context) {

	if c.Param("type") == "github" {
		url := helper.Github{}.GenerateUrl()
		c.Redirect(http.StatusFound, url)
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"code":    403,
		"message": "oauth forbidden",
	})
}

// Callback handles GET /oauth/callback/:type route
func (o *Oauth) Callback(c *gin.Context) {
	code := c.Query("code")
	state := c.Query("state")
	fmt.Println(code)
	fmt.Println(state)
	fmt.Println(c.Param("type"))

	if code != "" && c.Param("type") == "github" {
		accessToken, err := helper.Github{}.GetAccessToken(code, state)
		if err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		}
		fmt.Println(accessToken)

		c.JSON(http.StatusCreated, gin.H{
			"code":        200,
			"message":     "oauth github",
			"accessToken": accessToken,
		})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"code":    403,
		"message": "oauth forbidden",
	})
}
