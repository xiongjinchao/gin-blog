{{ define "css" }}
    <link rel="stylesheet" href="/public/plug-in/editor-md/css/editormd.min.css" />
{{ end }}

{{ define "content" }}

    <div class="container sub-container">
        <div class="row">
            <div class="col-lg-9 content-left mb-4">
                <div class="article-detail">
                    <h1 class="article-title text-center">{{ .article.Title}}</h1>
                    <div class="article-icon text-center">
                        <span><a href="#"><i class="fa fa-eye"></i> {{ .article.Hit}}</a></span>
                        <span><a href="#"><i class="fa fa-comment-o"></i> {{ .article.Comment}}</a></span>
                        <span><a href="#"><i class="fa fa-thumbs-o-up"></i> {{ .article.Favorite}}</a></span>
                        <span><i class="fa fa-clock-o"></i> {{ .article.CreatedAt.Format "2006/01/02"}}</span>
                    </div>
                    <div id="article-content" class="article-content">
                        <textarea style="display:none;">{{ .article.Content}}</textarea>
                    </div>
                </div>

                {{if .tags}}
                    <div class="article-tips">
                        <i class="fa fa-tags"></i>
                        {{ range $v := .tags }}
                            <a href="#">{{ $v.Tag }}</a>
                        {{ end }}
                    </div>
                {{ end }}
                <div class="article-notice">
                    <p class="m-0"><i class="fa fa-info-circle"></i> 未经允许不得转载：转载以<span class="text-primary">超链接形式</span>并注明出处。原文地址：<a class="text-primary" href="/article/detail/{{ .article.ID}}">《{{ .article.Title}}》</a></p>
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
                        {{ range $v := .related }}
                            <li class="list-group-item">
                                <div class="media">
                                    <div class="media-body">
                                        <h5 class="mt-0 mb-1"><a href="/article/detail/{{ $v.ID}}">{{ $v.Title }}</a></h5>
                                        <p class="mb-1 media-summary">{{ $v.Summary }}</p>
                                        <p class="mb-1 media-icon"><span><i class="fa fa-eye"></i> {{ $v.Hit }}</span> <span><i class="fa fa-comment"></i> {{ $v.Comment }}</span> <span><i class="fa fa-thumbs-o-up"></i> {{ $v.Favorite }}</span></p>
                                    </div>
                                    {{ if $v.File.Path }}
                                        <img src="{{ .image }}{{ $v.File.Path }}" class="ml-3">
                                    {{ end }}
                                </div>
                            </li>
                        {{ end }}
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
                        {{ range $v := .recommend }}
                            <li class="list-group-item"><a href="/article/detail/{{ $v.ID}}">{{ $v.Title }}</a><br/><span>阅读 {{ $v.Hit }}</span></li>
                        {{ end }}
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