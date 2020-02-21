package helper

import (
	"encoding/json"
	db "gin-blog/database"
	"gin-blog/models"
	"github.com/gin-gonic/contrib/sessions"
	"github.com/gin-gonic/gin"
	"math/rand"
	"strconv"
)

// get user from session
func GetUser(c *gin.Context) (auth models.Auth) {
	session := sessions.Default(c)
	passport := session.Get("passport")
	if passport != nil {
		_ = json.Unmarshal([]byte(passport.(string)), &auth)
	}
	return
}

// main menu
func GetMenu() []models.Menu {
	var menus, data []models.Menu
	data, err := (&models.Menu{}).GetCache()
	if err != nil {
		db.Mysql.Model(&models.Menu{}).Find(&menus)
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
		db.Mysql.Model(&models.Menu{}).Find(&categories)
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

	err = db.Mysql.Model(models.Article{}).
		Select("id,title,cover,category_id,summary,hit,useful,useless,comment,favorite,user_id,created_at").
		Where("audit = 1 and category_id = ? and ID < ?", categoryID, ID).
		Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id desc").
		First(&articles.Prev).Error
	(articles.Prev).SetTag()

	err = db.Mysql.Model(models.Article{}).
		Select("id,title,cover,category_id,summary,hit,useful,useless,comment,favorite,user_id,created_at").
		Where("audit = 1 and category_id = ? and ID > ?", categoryID, ID).
		Preload("File").Preload("User").Preload("ArticleCategory").
		Order("id asc").
		First(&articles.Next).Error
	(articles.Next).SetTag()
	return
}

// get the recommend article from cache
func GetRecommendArticle(ID, categoryID int64) (articles []models.Article, err error) {
	var SetRecommendArticle = func(ID, categoryID int64) (articles []models.Article, err error) {
		if err := db.Mysql.Model(models.Article{}).
			Select("id,title,cover,category_id,summary,hit,useful,useless,comment,favorite,user_id,created_at").
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

type RelatedBookChapter struct {
	Prev models.BookChapter
	Next models.BookChapter
}

// prev book chapter and next book chapter
func GetRelatedBookChapter(ID, bookID int64) (bookChapters RelatedBookChapter, err error) {

	err = db.Mysql.Model(models.BookChapter{}).
		Select("id,title,book_id,hit,useful,useless,comment,favorite,created_at").
		Where("audit = 1 and book_id = ? and ID < ?", bookID, ID).
		Order("id desc").
		First(&bookChapters.Prev).Error
	(bookChapters.Prev).SetTag()

	err = db.Mysql.Model(models.BookChapter{}).
		Select("id,title,book_id,hit,useful,useless,comment,favorite,created_at").
		Where("audit = 1 and book_id = ? and ID > ?", bookID, ID).
		Order("id asc").
		First(&bookChapters.Next).Error
	(bookChapters.Next).SetTag()
	return
}

type Subject struct {
	NumberOne int64
	Mark      string
	NumberTwo int64
	Result    int64
}

// make math subject
func SubjectChapter1() (subject Subject) {

	numberOne := rand.Int63n(100)
	numberTwo := rand.Int63n(100)

	mark := "+"
	if numberOne > numberTwo {
		mark = "-"
	}
	result := numberOne + numberTwo
	if mark == "-" {
		result = numberOne - numberTwo
	}
	return Subject{
		numberOne,
		mark,
		numberTwo,
		result,
	}
}
