package models

import (
	"fmt"
	db "gin-blog/database"
	"github.com/gin-gonic/gin"
)

type BookChapter struct {
	Base     `json:"base"`
	Title    string `json:"title" form:"title"`
	BookID   int64  `json:"book_id" form:"book_id" gorm:"column:book_id"`
	Chapter  string `json:"chapter" form:"chapter"`
	Audit    int64  `json:"audit" form:"audit"`
	Sort     int64  `json:"sort" form:"sort"`
	Hit      int64  `json:"hit" form:"hit"`
	Useful   int64  `json:"useful" form:"useful"`
	Useless  int64  `json:"useless" form:"useless"`
	Favorite int64  `json:"favorite" form:"favorite"`
	Comment  int64  `json:"comment" form:"comment"`
	Book     Book   `json:"book" validate:"-" gorm:"foreignKey:BookID"`
	Tags     []Tag  `json:"tags" form:"-"`
}

func (BookChapter) TableName() string {
	return "book_chapter"
}

// set tags data to book chapter
func (b *BookChapter) SetTag(bookChapter *BookChapter) {

	var tagModel []TagModel
	if err := db.Mysql.Model(&TagModel{}).Preload("Tag").Where("model = ? and model_id = ?", b.TableName(), bookChapter.ID).Find(&tagModel).Error; err != nil {
		(*bookChapter).Tags = nil
	}
	for _, t := range tagModel {
		(*bookChapter).Tags = append((*bookChapter).Tags, t.Tag)
	}
}

// set tags data to book chapter
func (b *BookChapter) SetTags(bookChapters *[]BookChapter) {

	for i, v := range *bookChapters {
		var tagModel []TagModel
		if err := db.Mysql.Model(&TagModel{}).Preload("Tag").Where("model = ? and model_id = ?", b.TableName(), v.ID).Find(&tagModel).Error; err != nil {
			_, _ = fmt.Fprintln(gin.DefaultWriter, err.Error())
			v.Tags = nil
		}
		for _, t := range tagModel {
			(*bookChapters)[i].Tags = append((*bookChapters)[i].Tags, t.Tag)
		}
	}
}
