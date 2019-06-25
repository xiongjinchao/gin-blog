package routers

import (
	"gin/controllers"
	"gin/middleware"
	"github.com/foolin/gin-template"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"html/template"
	"time"
)

const (
	SessionID  = "GOSESSID"
	SessionKey = "e63e42954d32a1d73568659fea764f4ad71ef534"
)

//Router defined all routers
func Router() *gin.Engine {
	router := gin.Default()

	// SESSION with cookie
	store := sessions.NewCookieStore([]byte(SessionID))
	// SESSION with redis
	// store, _ := sessions.NewRedisStore(10, "tcp", "localhost:6379", "", []byte("secret"))
	router.Use(sessions.Sessions(SessionKey, store))

	router.Static("/public", "./public")
	router.StaticFile("/favicon.ico", "./public/image/favicon.ico")

	//router.LoadHTMLGlob("views/**/*")
	router.HTMLRender = gintemplate.New(gintemplate.TemplateConfig{
		Root:      "views",
		Extension: ".tpl",
		Master:    "layouts/main",
		Partials:  []string{"layouts/header", "layouts/sidebar", "layouts/footer"},
		Funcs: template.FuncMap{
			"sub": func(a, b int) int {
				return a - b
			},
			"copy": func() string {
				return time.Now().Format("2006")
			},
		},
		DisableCache: true,
	})

	// Login

	router.GET("/login", (&controllers.Auth{}).Login)
	router.POST("/sign-in", (&controllers.Auth{}).SignIn)

	// Register
	router.GET("/register", (&controllers.Auth{}).Register)
	router.POST("/sign-up", (&controllers.Auth{}).SignUp)

	//Logout
	router.GET("/logout", (&controllers.Auth{}).Logout)

	admin := router.Group("admin")
	admin.Use((&middleware.Auth{}).CheckLogin())
	{
		//Admin Dashboard
		admin.GET("dashboard", (&controllers.Home{}).Dashboard)

		//User
		admin.GET("user", (&controllers.User{}).Index)

		admin.GET("user/create", (&controllers.User{}).Create)
		admin.POST("user", (&controllers.User{}).Store)
		admin.GET("user/edit/:id", (&controllers.User{}).Edit)
		admin.PUT("user/update/:id", (&controllers.User{}).Update)
		admin.GET("user/show/:id", (&controllers.User{}).Show)
		admin.DELETE("user/delete/:id", (&controllers.User{}).Destroy)

		//Article
		admin.GET("article", (&controllers.Article{}).Index)

		//Article Category
		admin.GET("article-category", (&controllers.ArticleCategory{}).Index)
	}

	return router
}
