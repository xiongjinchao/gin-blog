package routers

import (
	"gin-blog/config"
	"gin-blog/controllers"
	"gin-blog/controllers/blog"
	"gin-blog/helper"
	"github.com/foolin/gin-template"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"html/template"
	"reflect"
	"strings"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	// SESSION with cookie
	store := sessions.NewCookieStore([]byte(config.Setting["session"]["secret"]))
	store.Options(sessions.Options{
		"/",
		config.Setting["app"]["domain"],
		15 * 24 * 3600,
		false,
		true,
	})
	// SESSION with redis
	// store, _ := sessions.NewRedisStore(10, "tcp", "localhost:6379", "", []byte(config.Setting["session"]["secret"]))
	router.Use(sessions.Sessions(config.Setting["session"]["id"], store))

	router.Static("/public", "./public")
	router.StaticFile("/favicon.ico", "./public/image/favicon.ico")

	//router.LoadHTMLGlob("views/**/*")
	router.HTMLRender = gintemplate.New(gintemplate.TemplateConfig{
		Root:      "views",
		Extension: ".tpl",
		Master:    "layouts/main",
		Partials:  []string{"layouts/header", "layouts/footer"},
		Funcs: template.FuncMap{
			"Interface2Int64": helper.Interface2Int64,
			"TypeOf":          reflect.TypeOf,
			"Split":           strings.Split,
			"Contains":        strings.Contains,
			"Replace":         strings.Replace,
			"Add": func(x, y int) int {
				return x + y
			},
		},
		DisableCache: true,
	})

	// 首页
	home := &blog.Home{}
	router.GET("/", home.Index)

	// 文章
	article := &blog.Article{}
	router.GET("/article", article.Index)
	router.GET("/article/category/:tag", article.Category)
	router.GET("/article/detail/:id", article.Detail)

	// 书籍
	book := &blog.Book{}
	router.GET("/book", book.Index)
	router.GET("/book/detail/:id", book.Detail)

	// 链接分享
	friendLink := &blog.FriendLink{}
	router.GET("/link-share", friendLink.Index)

	// 教程
	course := &blog.Course{}
	router.GET("/course", course.Index)

	// 其他静态页
	page := &blog.Page{}
	router.GET("/about", page.About)

	// 第三方登录
	auth := &controllers.Auth{}
	router.GET("/auth/login/:type", auth.Login)
	router.GET("/auth/callback/:type", auth.Callback)

	// 获取当前用户信息
	router.GET("/auth/user", auth.User)

	return router
}
