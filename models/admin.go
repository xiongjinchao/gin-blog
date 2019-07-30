package models

import (
	"crypto/sha1"
	"encoding/hex"
)

type Admin struct {
	Base
	Name          string `json:"name" form:"name" validate:"required" gorm:"unique_index"`
	Email         string `json:"email" form:"email" validate:"email" gorm:"unique_index"`
	Mobile        string `json:"mobile" form:"mobile" validate:"required,numeric,len=11" gorm:"unique_index"`
	Password      string `json:"-" form:"password"`
	RememberToken string `json:"remember_token" form:"remember_token"`
}

func (Admin) TableName() string {
	return "admin"
}

func (m *Admin) GeneratePassword(password string) string {
	s := sha1.New()
	s.Write([]byte(password))
	return hex.EncodeToString(s.Sum([]byte("")))
}
