package helper

import (
	"crypto/sha1"
	"encoding/hex"
	"encoding/json"
	"gin-blog/config"
	"io/ioutil"
	"net/http"
	"strconv"
	"strings"
	"time"
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
	SiteAdmin         string `json:"site_admin"`
	Name              string `json:"name"`
	Blog              string `json:"blog"`
	Location          string `json:"location"`
	Email             string `json:"email"`
	Hireable          string `json:"hireable"`
	Bio               string `json:"bio"`
	PublicRepos       string `json:"public_repos"`
	PublicGists       string `json:"public_gists"`
	Followers         string `json:"followers"`
	Following         string `json:"following"`
	CreatedAt         string `json:"created_at"`
	UpdatedAt         string `json:"updated_at"`
}

func (g Github) GenerateUrl() (url string) {

	clientID := config.Setting["github"]["id"]
	now := time.Now().Unix()
	s := sha1.New()
	s.Write([]byte(strconv.FormatInt(now, 10)))
	state := hex.EncodeToString(s.Sum([]byte("")))
	return "https://github.com/login/oauth/authorize?client_id=" + clientID + "&state=" + state + "&scope=user:email"

}

func (g Github) GetAccessToken(code, state string) (github Github, err error) {

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
	/*
		"login":"xiongjinchao",
		    "id":10016730,
		    "node_id":"MDQ6VXNlcjEwMDE2NzMw",
		    "avatar_url":"https://avatars3.githubusercontent.com/u/10016730?v=4",
		    "gravatar_id":"",
		    "url":"https://api.github.com/users/xiongjinchao",
		    "html_url":"https://github.com/xiongjinchao",
		    "followers_url":"https://api.github.com/users/xiongjinchao/followers",
		    "following_url":"https://api.github.com/users/xiongjinchao/following{/other_user}",
		    "gists_url":"https://api.github.com/users/xiongjinchao/gists{/gist_id}",
		    "starred_url":"https://api.github.com/users/xiongjinchao/starred{/owner}{/repo}",
		    "subscriptions_url":"https://api.github.com/users/xiongjinchao/subscriptions",
		    "organizations_url":"https://api.github.com/users/xiongjinchao/orgs",
		    "repos_url":"https://api.github.com/users/xiongjinchao/repos",
		    "events_url":"https://api.github.com/users/xiongjinchao/events{/privacy}",
		    "received_events_url":"https://api.github.com/users/xiongjinchao/received_events",
		    "type":"User",
		    "site_admin":false,
		    "name":"Ted",
		    "company":null,
		    "blog":"susan.org.cn",
		    "location":"beijing",
		    "email":"xiongjinchao@gmail.com",
		    "hireable":null,
		    "bio":"PHPer & Gopher",
		    "public_repos":6,
		    "public_gists":0,
		    "followers":0,
		    "following":1,
		    "created_at":"2014-12-01T04:04:21Z",
		    "updated_at":"2019-10-24T14:12:24Z"
	*/

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
