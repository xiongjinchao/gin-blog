package helper

import (
	"crypto/sha1"
	"encoding/hex"
	"gin-blog/config"
	"io/ioutil"
	"net/http"
	"strconv"
	"strings"
	"time"
)

type Github struct{}

func (g Github) GenerateUrl() (url string) {

	clientID := config.Setting["github"]["id"]
	now := time.Now().Unix()
	s := sha1.New()
	s.Write([]byte(strconv.FormatInt(now, 10)))
	state := hex.EncodeToString(s.Sum([]byte("")))
	return "https://github.com/login/oauth/authorize?client_id=" + clientID + "&state=" + state + "&scope=user:email"

}

func (g Github) GetAccessToken(code, state string) (result string, err error) {

	client := &http.Client{}
	url := "https://github.com/login/oauth/access_token"
	clientID := config.Setting["github"]["id"]
	clientSecret := config.Setting["github"]["secret"]
	req, err := http.NewRequest("POST", url, strings.NewReader("client_id="+clientID+"&client_secret="+clientSecret+"&code="+code))
	if err != nil {
		return
	}
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Set("Accept", "application/json")

	resp, err := client.Do(req)

	defer func() {
		_ = resp.Body.Close()
	}()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return
	}

	result = string(body)
	return result, nil
}
