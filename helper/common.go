package helper

import (
	"encoding/json"
	"fmt"
	db "gin-blog/database"
	"gin-blog/models"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"strconv"
)

// get user from session
func GetUser(c *gin.Context) (auth models.Auth) {
	session := sessions.Default(c)
	passport := session.Get("passport")
	if passport != nil {
		if err := json.Unmarshal([]byte(passport.(string)), &auth); err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
			return
		}
	}
	return
}

// main menu
func GetMenu() []models.Menu {
	var menus, data []models.Menu
	data, err := (&models.Menu{}).GetCache()
	if err != nil {
		if err := db.Mysql.Model(&models.Menu{}).Find(&menus).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		}
		(&models.Menu{}).SetSort(&menus, 0, &data)
		(&models.Menu{}).SetData(&data)
	}

	return data
}

// get all article category
func GetArticleCategories() []models.ArticleCategory {
	var categories, data []models.ArticleCategory
	data, err := (&models.ArticleCategory{}).GetCache()
	if err != nil {
		if err := db.Mysql.Model(&models.Menu{}).Find(&categories).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		}
		(&models.ArticleCategory{}).SetSort(&categories, 0, &data)
		(&models.ArticleCategory{}).SetData(&data)
	}

	return data
}

// get the newest article from cache
func GetNewNote() (articles []models.Article, err error) {

	var SetNewNote = func() (articles []models.Article, err error) {
		if err := db.Mysql.Model(models.Article{}).
			Select("id,title,created_at").
			Where("audit = 1 and category_id in (3,4,5,6,7)").
			Order("id desc").
			Limit(8).
			Find(&articles).Error; err != nil {
			return articles, err
		}

		if len(articles) == 0 {
			return
		}

		article, err := json.Marshal(articles)
		if err != nil {
			return
		}

		db.Redis.Set("new-note", string(article), 600*1000000000)
		return
	}

	data, err := db.Redis.Get("new-note").Result()
	if data == "" || err != nil {
		return SetNewNote()
	}

	if err := json.Unmarshal([]byte(data), &articles); err != nil {
		return SetNewNote()
	}

	return
}

// get the newest article from cache
func GetNewArticle() (articles []models.Article, err error) {
	var SetNewArticle = func() (articles []models.Article, err error) {
		if err := db.Mysql.Model(models.Article{}).
			Select("id,title,created_at").
			Where("audit = 1 and category_id in (8,9)").
			Order("id desc").
			Limit(8).
			Find(&articles).Error; err != nil {
			return articles, err
		}

		if len(articles) == 0 {
			return
		}

		article, err := json.Marshal(articles)
		if err != nil {
			return
		}

		db.Redis.Set("new-article", string(article), 600*1000000000)
		return
	}

	data, err := db.Redis.Get("new-article").Result()
	if data == "" || err != nil {
		return SetNewArticle()
	}

	if err := json.Unmarshal([]byte(data), &articles); err != nil {
		return SetNewArticle()
	}

	return
}

type RelatedArticle struct {
	Prev models.Article
	Next models.Article
}

// prev article and next article
func GetRelatedArticle(ID, categoryID int64) (articles RelatedArticle, err error) {

	if err := db.Mysql.Model(models.Article{}).
		Select("id,title,cover,category_id,summary,hit,comment,favorite,user_id,created_at").
		Where("audit = 1 and category_id = ? and ID < ?", categoryID, ID).
		Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id desc").
		First(&articles.Prev).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.Article{}).SetTag(&articles.Prev)

	if err := db.Mysql.Model(models.Article{}).
		Select("id,title,cover,category_id,summary,hit,comment,favorite,user_id,created_at").
		Where("audit = 1 and category_id = ? and ID > ?", categoryID, ID).
		Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id asc").
		First(&articles.Next).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	(&models.Article{}).SetTag(&articles.Next)
	return
}

// hot article
func GetHotArticle(ID, categoryID int64) (article models.Article, err error) {

	if err := db.Mysql.Model(models.Article{}).
		Select("id,title,cover,category_id,summary,hit,comment,favorite,user_id,created_at").
		Where("audit = 1 and hot =1 and cover >0 and category_id = ? and ID != ?", categoryID, ID).
		Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id desc").
		First(&article).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
	}
	return

}

// get the recommend article from cache
func GetRecommendArticle(ID, categoryID int64) (articles []models.Article, err error) {
	var SetRecommendArticle = func(ID, categoryID int64) (articles []models.Article, err error) {
		if err := db.Mysql.Model(models.Article{}).
			Select("id,title,cover,category_id,summary,hit,comment,favorite,user_id,created_at").
			Where("audit = 1 and category_id = ? and ID != ?", categoryID, ID).
			Preload("File").Preload("User").Preload("ArticleCategory").
			Order("id desc").
			Limit(8).
			Find(&articles).Error; err != nil {
			return articles, err
		}

		if len(articles) == 0 {
			return
		}
		(&models.Article{}).SetTags(&articles)

		article, err := json.Marshal(articles)
		if err != nil {
			return
		}

		db.Redis.Set("recommend-article"+strconv.FormatInt(categoryID, 10), string(article), 600*1000000000)
		return
	}

	data, err := db.Redis.Get("related-article" + strconv.FormatInt(categoryID, 10)).Result()
	if data == "" || err != nil {
		return SetRecommendArticle(ID, categoryID)
	}

	if err := json.Unmarshal([]byte(data), &articles); err != nil {
		return SetRecommendArticle(ID, categoryID)
	}

	return
}
