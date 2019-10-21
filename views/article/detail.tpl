{{ define "css" }}
    <link rel="stylesheet" href="/public/plug-in/editor-md/css/editormd.min.css" />
{{ end }}

{{ define "content" }}

    <div class="container sub-container">
        <div class="row">
            <div class="col-lg-9 content-left mb-4">
                <div class="article-detail">
                    <h1 class="article-title text-center">【Golang】json自定义序列化的深入解析</h1>
                    <div class="article-icon text-center">
                        <span><a href="#"><i class="fa fa-eye"></i> 520</a></span>
                        <span><a href="#"><i class="fa fa-comment-o"></i> 3</a></span>
                        <span><a href="#"><i class="fa fa-thumbs-o-up"></i> 100</a></span>
                        <span><i class="fa fa-clock-o"></i> 2019-10-01</span>
                    </div>
                    <div id="article-content" class="article-content">
                        <textarea style="display:none;">主要区分一下两个方面的内容：

- 单纯的方法定义
- 通过接口传递参数

##### 1、 单纯的方法定义

> go语言内部会自动进行值和指针的转换, 代码在编译的时候不会出错；区别在于使用指针定义方法，方法操作的是该数据本身；而使用值定义方法时，方法操作的是该数据的拷贝。


> 总结:如果使用除接口类型以外的类型作为接收者时，使用值和指针调用方法不会出现编译错误； 如果使用接口类型的变量（实现了该接口）调用方法时，使用值调用指针定义的方法时会出现编译出错。

1、 使用值定义方法，使用值调用方法的情况

```go
type user struct {
    name string
    email string
}

func (u user) notify() {
    //将传入的参数复制一份，赋值给u
    u.name = "Jack"
    fmt.Println("Send email to", u.name, u.email)
}

func main() {
    user := user{"Andy", "1139329@163.com"}
    user.notify()
    fmt.Println(user)
}

//输出（名子并不会改变）：
Send email to Jack 1139329@163.com
{Andy 1139329@163.com}

```

2、 使用值定义方法，使用指针调用方法的情况

> 由于定义方法时使用的是值，在编译过程中会对调用者为指针的类型进行解引用，内部实现为 *user.notify()

```go
type user struct {
    name string
    email string
}

func (u user) notify() {
    //将传入的参数复制一份，赋值给u
    u.name = "Jack"
    fmt.Println("Send email to", u.name, u.email)
}

func main() {
    user := &user{"Andy", "1139329@163.com"}
    user.notify()
    fmt.Println(user)
}

//输出（名子也不会改变）：
Send email to Jack 1139329@163.com
{Andy 1139329@163.com}
```

3、 使用指针定义方法，使用指针调用方法的情况

```go
type user struct {
    name string
    email string
}

func (u *user) notify() {
    u.name = "Jack"
    fmt.Println("Send email to", u.name, u.email)
}

func main() {
    user := user{"Andy", "1139329@163.com"}
    user.notify()
    fmt.Println(user)
}

//输出（名子会改变）：
Send email to Jack 1139329@163.com
{Jack 1139329@163.com}
```

4、 使用指针定义方法，使用值调用方法的情况

> 内部实现为 *user.notify()

```go
type user struct {
    name string
    email string
}

func (u *user) notify() {
    u.name = "Jack"
    fmt.Println("Send email to", u.name, u.email)
}

func main() {
    user := user{"Andy", "1139329@163.com"}
    user.notify()
    fmt.Println(user)
}

//输出（名子会改变）：
Send email to Jack 1139329@163.com
{Jack 1139329@163.com}
```

#####2、 通过接口传递参数

1、 接受者receiver为值，使用值传递的情况

```go
type user struct {
    name  string
    email string
}

type notifyInterface interface {
    notify()
}

func (u user) notify() {
    fmt.Println("Send email to", u.name, u.email)
}

func sendNotification(n notifyInterface) {
    n.notify()
}

func main() {
    user := user{"Andy", "1139329@163.com"}
    sendNotification(user)
}

//编译成功
```

2、 接受者receiver为值，使用指针传递的情况

```go
type user struct {
    name  string
    email string
}

type notifyInterface interface {
    notify()
}

func (u user) notify() {
    fmt.Println("Send email to", u.name, u.email)
}

func sendNotification(n notifyInterface) {
    n.notify()
}

func main() {
    user := &user{"Andy", "1139329@163.com"}
    sendNotification(user)
}

//编译成功
```

3、 接受者receiver为指针，使用指针传递的情况

```go
type user struct {
    name  string
    email string
}

type notifyInterface interface {
    notify()
}

func (u *user) notify() {
    fmt.Println("Send email to", u.name, u.email)
}

func sendNotification(n notifyInterface) {
    n.notify()
}

func main() {
    user := &user{"Andy", "1139329@163.com"}
    sendNotification(user)
}

//编译成功
```

4、 接受者receiver为指针，使用值传递的情况

```go
type user struct {
    name  string
    email string
}

type notifyInterface interface {
    notify()
}

func (u *user) notify() {
    fmt.Println("Send email to", u.name, u.email)
}

func sendNotification(n notifyInterface) {
    n.notify()
}

func main() {
    user := user{"Andy", "1139329@163.com"}
    sendNotification(user)
}

//编译失败（使用指针接受者来实现一个接口，值类型无法实现对应的接口）
cannot use user (type user) as type notifyInterface in argument to sendNotification:
user does not implement notifyInterface (notify method has pointer receiver)
```
针对以上情况，《Go语言实战》一书中这样讲到，首先这是Go语言的一种规则，具体如下：如果使用指针接受者来实现一个接口，那么只有指向那个类型的指针才能够实现对应的接口。如果使用值接受者来实现一个接口，那么那个类型的值和指针都能够实现对应的接口。

为什么会有这样的限制呢：作者解释为go编译器并不总能自动获得一个值得地址！


                        </textarea>
                    </div>
                </div>

                <div class="article-tips">
                    <i class="fa fa-tags"></i>
                    <a href="#">Golang</a> <a href="#">Slice</a>
                </div>
                <div class="article-notice">
                    <p class="m-0"><i class="fa fa-info-circle"></i> 未经允许不得转载：转载以<span class="text-primary">超链接形式</span>并注明出处。原文地址：<a class="text-primary" href="/article/detail/1">《【Golang】json自定义序列化的深入解析》</a></p>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        相关推荐
                    </h1>
                    <small class="text-black-50">Recommend</small>
                </div>

                <div class="card border-0 mt-4 article-list">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="/article/detail/1">GCTT：Go中文翻译组成立了，期待大家的加入</a></h5>
                                    <p class="mb-1 media-summary">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                                    <p class="mb-1 media-icon"><span><i class="fa fa-eye"></i> 520</span> <span><i class="fa fa-comment"></i> 3</span> <span><i class="fa fa-thumbs-o-up"></i> 100</span></p>
                                </div>
                                <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/kaike.jpg" class="ml-3">
                            </div>
                        </li>

                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="#">PHP与Golang如何通信</a></h5>
                                    <p class="mb-1 media-summary">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                                    <p class="mb-1 media-icon"><span><i class="fa fa-eye"></i> 520</span> <span><i class="fa fa-comment"></i> 3</span> <span><i class="fa fa-thumbs-o-up"></i> 100</span></p>
                                </div>
                                <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/kaike.jpg" class="ml-3">
                            </div>
                        </li>
                    </ul>
                </div>

            </div>
            <div class="col-lg-3 content-right">
                <div class="card border-0 recommend">
                    <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/next.png" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title"><a href="#">微信支付的GoLang接口封装方案</a></h5>
                        <p class="card-text">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><a href="#">Rabin-Karp算法在go的实现</a><br/><span>阅读 120</span></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a><br/><span>阅读 120</span></li>
                        <li class="list-group-item"><a href="#">go平滑重启调研选型和项目实践</a><br/><span>阅读 120</span></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a><br/><span>阅读 120</span></li>
                        <li class="list-group-item"><a href="#">go平滑重启调研选型和项目实践</a><br/><span>阅读 120</span></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a><br/><span>阅读 120</span></li>
                        <li class="list-group-item"><a href="#">go平滑重启调研选型和项目实践</a><br/><span>阅读 120</span></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a><br/><span>阅读 120</span></li>
                    </ul>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        热门标签
                    </h1>
                    <small class="text-black-50">Recommend</small>
                </div>

                <div class="card border-0 mt-4 tag">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><a href="#">PHP(120)</a></li>
                        <li class="list-group-item"><a href="#">Golang(800)</a></li>
                        <li class="list-group-item"><a href="#">MySQL(10)</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="mt-5"></div>
    </div>

{{ end }}

{{ define "js" }}
    <script src="/public/plug-in/editor-md/lib/marked.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/prettify.min.js"></script>

    <script src="/public/plug-in/editor-md/lib/raphael.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/underscore.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/sequence-diagram.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/flowchart.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/jquery.flowchart.min.js"></script>

    <script src="/public/plug-in/editor-md/editormd.js"></script>

    <script type="text/javascript">
        $(function() {
            // markdown 转 HTML
            var editormdView = editormd.markdownToHTML("article-content", {
                htmlDecode      : "style,script,iframe",  // you can filter tags decode
                emoji           : true,
                taskList        : true,
                tex             : true,  // 默认不解析
                flowChart       : true,  // 默认不解析
                sequenceDiagram : true,  // 默认不解析
            });
            $("#article-content").addClass("editormd-preview-theme-dark");
        });
    </script>
{{ end }}