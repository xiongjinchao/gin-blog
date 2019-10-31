package helper

import (
	"encoding/base64"
	"encoding/json"
	"gin-blog/config"
	"io/ioutil"
	"net/http"
	"strings"
)

type Github struct {
	AccessToken       string `json:"access_token"`
	Login             string `json:"login"`
	ID                int64  `json:"id"`
	NodeID            string `json:"node_id"`
	AvatarUrl         string `json:"avatar_url"`
	GravatarID        string `json:"gravatar_id"`
	Url               string `json:"url"`
	HtmlUrl           string `json:"html_url"`
	FollowersUrl      string `json:"followers_url"`
	FollowingUrl      string `json:"following_url"`
	GistsUrl          string `json:"gists_url"`
	StarredUrl        string `json:"starred_url"`
	SubscriptionsUrl  string `json:"subscriptions_url"`
	OrganizationsUrl  string `json:"organizations_url"`
	ReposUrl          string `json:"repos_url"`
	EventsUrl         string `json:"events_url"`
	ReceivedEventsUrl string `json:"received_events_url"`
	Type              string `json:"type"`
	SiteAdmin         bool   `json:"site_admin"`
	Name              string `json:"name"`
	Blog              string `json:"blog"`
	Location          string `json:"location"`
	Email             string `json:"email"`
	Hireable          string `json:"hireable"`
	Bio               string `json:"bio"`
	PublicRepos       int64  `json:"public_repos"`
	PublicGists       int64  `json:"public_gists"`
	Followers         int64  `json:"followers"`
	Following         int64  `json:"following"`
	CreatedAt         string `json:"created_at"`
	UpdatedAt         string `json:"updated_at"`
}

func (g Github) GenerateUrl(redirect string) (url string) {

	clientID := config.Setting["github"]["id"]
	state := base64.URLEncoding.EncodeToString([]byte(redirect))
	return "https://github.com/login/oauth/authorize?client_id=" + clientID + "&state=" + state + "&scope=user:email"

}

func (g Github) GetAccessToken(code string) (github Github, err error) {

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
	if err != nil {
		return
	}

	defer func() {
		_ = resp.Body.Close()
	}()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return
	}

	if err = json.Unmarshal(body, &github); err != nil {
		return
	}

	return
}

func (g Github) GetUser(accessToken string) (github Github, err error) {

	client := &http.Client{}
	url := "https://api.github.com/user"
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return
	}
	req.Header.Set("Authorization", "token "+accessToken)
	req.Header.Set("Accept", "application/json")

	resp, err := client.Do(req)
	if err != nil {
		return
	}

	defer func() {
		_ = resp.Body.Close()
	}()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return
	}

	if err = json.Unmarshal(body, &github); err != nil {
		return
	}
	github.AccessToken = accessToken
	return

}
