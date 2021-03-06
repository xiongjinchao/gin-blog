package models

import (
	"fmt"
	db "gin-blog/database"
	"github.com/gin-gonic/gin"
)

type Article struct {
	Base            `json:"base"`
	Title           string          `json:"title" form:"title"`
	Cover           int64           `json:"cover" form:"cover"`
	CategoryID      int64           `json:"category_id" form:"category_id" gorm:"column:category_id"`
	Summary         string          `json:"summary" form:"summary"`
	Content         string          `json:"content" form:"content"`
	Audit           int64           `json:"audit" form:"audit"`
	Hot             int64           `json:"hot" form:"hot"`
	Recommend       int64           `json:"recommend" form:"recommend"`
	Hit             int64           `json:"hit" form:"hit"`
	Useful          int64           `json:"useful" form:"useful"`
	Useless         int64           `json:"useless" form:"useless"`
	Favorite        int64           `json:"favorite" form:"favorite"`
	Comment         int64           `json:"comment" form:"comment"`
	UserID          int64           `json:"user_id" form:"user_id" gorm:"column:user_id"`
	Author          string          `json:"author" form:"author"`
	Source          string          `json:"source" form:"source"`
	SourceUrl       string          `json:"source_url" form:"source_url"`
	Keyword         string          `json:"keyword" form:"keyword"`
	ArticleCategory ArticleCategory `json:"article_category" validate:"-" gorm:"foreignKey:CategoryID;AssociationForeignKey:ID"`
	User            User            `json:"user" validate:"-" gorm:"foreignKey:UserID"`
	File            File            `json:"file" validate:"-" gorm:"foreignKey:Cover;AssociationForeignKey:ID"`
	Tags            []Tag           `json:"tags" form:"-"`
}

func (Article) TableName() string {
	return "article"
}

// set tags data to article
func (a *Article) SetTag() {

	var tagModel []TagModel
	if err := db.Mysql.Model(&TagModel{}).Preload("Tag").Where("model = ? and model_id = ?", a.TableName(), a.ID).Find(&tagModel).Error; err != nil {
		_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
		(*a).Tags = nil
	}
	for _, t := range tagModel {
		(*a).Tags = append((*a).Tags, t.Tag)
	}
}

// set tags data to article
func (a *Article) SetTags(articles *[]Article) {

	for i, v := range *articles {
		var tagModel []TagModel
		if err := db.Mysql.Model(&TagModel{}).Preload("Tag").Where("model = ? and model_id = ?", a.TableName(), v.ID).Find(&tagModel).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
			v.Tags = nil
		}
		for _, t := range tagModel {
			(*articles)[i].Tags = append((*articles)[i].Tags, t.Tag)
		}
	}
}
