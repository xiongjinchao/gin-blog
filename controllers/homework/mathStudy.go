package homework

import (
	"gin-blog/config"
	"gin-blog/helper"
	"github.com/gin-gonic/gin"
	"net/http"
)

type MathStudy struct{}

// About handles GET /about route
func (m *MathStudy) Chapters1(c *gin.Context) {

	var subjects []helper.Subject
	count := 0
	for {
		subject := helper.SubjectChapter1()
		if subject.Result > 0 && subject.Result < 20 {
			count++
			subjects = append(subjects, subject)
		}
		if count >= 20 {
			break
		}
	}

	c.HTML(http.StatusOK, "math-study/chapters-1", gin.H{
		"title":    "数学题第一章：20以内的加减法练习题" + "-" + config.Setting["app"]["title"],
		"user":     helper.GetUser(c),
		"menu":     helper.GetMenu(),
		"count":    len(subjects),
		"score":    100 / len(subjects),
		"subjects": subjects,
	})
}
