{{ define "css" }}
    <link rel="stylesheet" href="/public/plug-in/editor-md/css/editormd.preview.css" />
    <link rel="stylesheet" href="/public/plug-in/editor-md/css/tomorrow-night-eighties.css">
{{ end }}

{{ define "content" }}

    <div class="container sub-container">
        <div class="row">
            <div class="col-lg-9 content-left mb-4">
                <h1 class="article-title text-center">【Golang】json自定义序列化的深入解析</h1>
                <div class="article-icon text-center">
                    <span>来源：<a href="#">简书</a></span>
                    <span><a href="#"><i class="fa fa-eye"></i> 520</a></span>
                    <span><a href="#"><i class="fa fa-comment-o"></i> 3</a></span>
                    <span><a href="#"><i class="fa fa-heart-o"></i> 100</a></span>
                    <span><i class="fa fa-clock-o"></i> 2019-10-01</span>
                </div>
                <div id="article-content" class="article-content">
                    <textarea style="display:none;">> golang标准库本身没有提供一个去除slice中重复元素的函数，需要自己去实现。今天读源码时发现了一个，算是比较优秀的技巧了，如果你有更好的办法，欢迎讨论！

另外让我们看一下空struct的作用，他之前一直没有被我重视，看来以后要多审视自己的coding了！

```go
func main() {
    s := []string{"hello", "world", "hello", "golang", "hello", "ruby", "php", "java"}

    fmt.Println(removeDuplicateElement(s))
}

func removeDuplicateElement(addrs []string) []string {
    result := make([]string, 0, len(addrs))
    temp := map[string]struct{}{}
    for _, item := range addrs {
        if _, ok := temp[item]; !ok {
            temp[item] = struct{}{}
            result = append(result, item)
        }
    }
    return result
}

//output:
[hello world golang ruby php java]
```

点评

- 该函数总共初始化两个变量，一个长度为0的slice，一个空map。由于slice传参是按引用传递，没有创建额外的变量。

- 只是用了一个for循环，代码更简洁易懂。

- 利用了map的多返回值特性。

- 空struct不占内存空间，可谓巧妙。

                    </textarea>
                </div>
                <div class="article-tips text-right">
                    <i class="fa fa-tags"></i>
                    <a href="#">Golang</a> <a href="#">Slice</a>
                </div>
                <div class="article-notice">
                    <p class="mb-1">未经允许不得转载：转载以<span class="text-primary">超链接形式</span>并注明出处。</p>
                    <p class="m-0">原文地址：<a class="text-primary" href="/article/detail/1">《【Golang】json自定义序列化的深入解析》</a></p>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        相关推荐
                    </h1>
                    <small class="text-black-50">Recommend</small>
                </div>

                <div class="card mt-4 article-list">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="/article/detail/1">GCTT：Go中文翻译组成立了，期待大家的加入</a></h5>
                                    <p class="mb-1 media-summary">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                                    <p class="mb-1 media-icon"><span><i class="fa fa-eye"></i> 520</span> <span><i class="fa fa-comment"></i> 3</span> <span><i class="fa fa-heart"></i> 100</span></p>
                                </div>
                                <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/kaike.jpg" class="ml-3">
                            </div>
                        </li>

                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="#">PHP与Golang如何通信</a></h5>
                                    <p class="mb-1 media-summary">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                                    <p class="mb-1 media-icon"><span><i class="fa fa-eye"></i> 520</span> <span><i class="fa fa-comment"></i> 3</span> <span><i class="fa fa-heart"></i> 100</span></p>
                                </div>
                                <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/kaike.jpg" class="ml-3">
                            </div>
                        </li>
                    </ul>
                </div>

            </div>
            <div class="col-lg-3 content-right">
                <div class="card">
                    <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/next.png" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title"><a href="#">微信支付的GoLang接口封装方案</a></h5>
                        <p class="card-text">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><a href="#">Rabin-Karp算法在go的实现</a></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a></li>
                        <li class="list-group-item"><a href="#">go平滑重启调研选型和项目实践</a></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a></li>
                        <li class="list-group-item"><a href="#">go平滑重启调研选型和项目实践</a></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a></li>
                        <li class="list-group-item"><a href="#">go平滑重启调研选型和项目实践</a></li>
                        <li class="list-group-item"><a href="#">你离告别GOPATH只差一步</a></li>
                        <li class="list-group-item"><a href="#">go平滑重启调研选型和项目实践</a></li>
                    </ul>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        热门标签
                    </h1>
                    <small class="text-black-50">Recommend</small>
                </div>

                <div class="card mt-4">
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
            var editormdView = editormd.markdownToHTML("article-content", {
                htmlDecode      : "style,script,iframe",  // you can filter tags decode
                emoji           : true,
                taskList        : true,
                tex             : true,  // 默认不解析
                flowChart       : true,  // 默认不解析
                sequenceDiagram : true,  // 默认不解析
            });
        });
    </script>
{{ end }}