package models

type Tag struct {
	Base `json:"base"`
	Name string `json:"name" form:"name"`
}

func (Tag) TableName() string {
	return "tag"
}
