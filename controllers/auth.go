package controllers

import (
	"encoding/json"
	"fmt"
	db "gin-blog/database"
	"gin-blog/helper"
	"gin-blog/models"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

type Auth struct{}

// Login handles GET /auth/login/:type route
func (a *Auth) Login(c *gin.Context) {

	if c.Param("type") == "github" {
		url := helper.Github{}.GenerateUrl()
		c.Redirect(http.StatusFound, url)
		return
	}

	c.JSON(http.StatusBadRequest, gin.H{
		"code":    401,
		"message": "oauth forbidden",
	})
}

// Callback handles GET /auth/callback/:type route
func (a *Auth) Callback(c *gin.Context) {

	code := c.Query("code")
	state := c.Query("state")
	if code != "" && c.Param("type") == "github" {
		github, err := helper.Github{}.GetAccessToken(code, state)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}
		github, err = helper.Github{}.GetUser(github.AccessToken)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}

		userAuth := models.UserAuth{}
		user := models.User{}

		db.Mysql.Where("openid = ?", github.ID).First(&userAuth)
		if userAuth.UserID > 0 {
			db.Mysql.First(&user, userAuth.UserID)
		}

		user.Name = github.Name
		user.Email = github.Email
		if user.Name == "" {
			user.Name = github.Login
		}
		if userAuth.UserID > 0 {
			user.ID = userAuth.UserID
		}
		if err := db.Mysql.Model(&models.User{}).Save(&user).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}

		if user.AccessToken, user.ResetKey, err = user.GenerateToken(user.ID); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}

		if err := db.Mysql.Save(&user).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}

		userAuth.UserID = user.ID
		userAuth.Type = "github"
		userAuth.AccessToken = github.AccessToken
		userAuth.OpenID = strconv.FormatInt(github.ID, 10)
		userAuth.Nickname = user.Name
		userAuth.Avatar = github.AvatarUrl
		if err := db.Mysql.Model(&models.UserAuth{}).Save(&userAuth).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}

		passport, err := json.Marshal(models.Auth{
			user,
			userAuth,
		})
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}

		// login success
		session := sessions.Default(c)
		session.Set("passport", string(passport))
		if err := session.Save(); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"code":    401,
				"message": err.Error(),
			})
			return
		}

		c.Redirect(http.StatusFound, "/")
		return
	}

	c.JSON(http.StatusBadRequest, gin.H{
		"code":    401,
		"message": "oauth forbidden",
	})
}

// User handles GET /auth/user route
func (a *Auth) User(c *gin.Context) {

	session := sessions.Default(c)
	passport := session.Get("passport")
	auth := models.Auth{}
	if passport != nil {
		if err := json.Unmarshal([]byte(passport.(string)), &auth); err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
			return
		}
	}

	c.JSON(http.StatusCreated, gin.H{
		"code":    200,
		"message": "",
		"data":    auth,
	})
}

// Logout handles GET /auth/logout route
func (a *Auth) Logout(c *gin.Context) {
	session := sessions.Default(c)
	session.Delete("passport")
	session.Clear()
	_ = session.Save()
	c.Redirect(http.StatusFound, "/")
}
