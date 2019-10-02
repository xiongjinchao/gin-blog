package routers

import (
	"gin-blog/config"
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
	router.GET("/book/detail", book.Detail)

	// 友情链接
	friendLink := &blog.FriendLink{}
	router.GET("/friend-link", friendLink.Index)

	// 我的收藏
	collection := &blog.Collection{}
	router.GET("/collection", collection.Index)

	// 其他静态页
	page := &blog.Page{}
	router.GET("/about", page.About)

	return router
}
