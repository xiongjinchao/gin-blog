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
                        <span><a href="#"><i class="fal fa-eye"></i> {{ .article.Hit}}</a></span>
                        <span><a href="#"><i class="fal fa-comments"></i> {{ .article.Comment}}</a></span>
                        <span><a href="#"><i class="fal fa-thumbs-up"></i> {{ .article.Favorite}}</a></span>
                        <span><i class="fal fa-calendar-alt"></i> {{ .article.CreatedAt.Format "2006/01/02"}}</span>
                    </div>
                    <div id="article-content" class="article-content">
                        <textarea style="display:none;">{{ .article.Content}}</textarea>
                    </div>
                </div>

                {{if .tags}}
                    <div class="article-tips">
                        <i class="fal fa-tags"></i>
                        {{ range $v := .tags }}
                            <a href="#">{{ $v.Tag }}</a>
                        {{ end }}
                    </div>
                {{ end }}
                <div class="article-notice">
                    <p class="m-0"><i class="fal fa-info-circle-circle"></i> 未经允许不得转载：转载以<span class="text-primary">超链接形式</span>并注明出处。原文地址：<a class="text-primary" href="/article/detail/{{ .article.ID}}">《{{ .article.Title}}》</a></p>
                </div>

                <div class="action" style="width:5rem;position:fixed;top:300px;left:100px;">
                    <div style="margin-top:.4rem">
                        <span class="fa-stack" style="color:#666666;font-size:1.4rem;">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-thumbs-up fa-stack-1x fa-inverse"></i>
                        </span>
                        <b style="font-size:.875rem;">99+</b>
                    </div>
                    <div style="margin-top:.4rem">
                        <span class="fa-stack" style="color:#666666;font-size:1.4rem;">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-comments fa-stack-1x fa-inverse"></i>
                        </span>
                        <b style="font-size:.875rem;">99+</b>
                    </div>
                    <div style="margin-top:.4rem">
                        <span class="fa-stack" style="color:#666666;font-size:1.4rem;">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-star fa-stack-1x fa-inverse"></i>
                        </span>
                        <b style="font-size:.875rem;">35</b>
                    </div>
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
                        {{ $image := .image }}
                        {{ if gt .related.Prev.ID 0 }}
                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="/article/detail/{{ .related.Prev.ID}}">{{ .related.Prev.Title }}</a></h5>
                                    <p class="mb-1 media-summary">{{ .related.Prev.Summary }}</p>
                                    <p class="mb-1 media-icon">
                                        <span><i class="fal fa-eye"></i> {{ .related.Prev.Hit }}</span>
                                        <span><i class="fal fa-comments"></i> {{ .related.Prev.Comment }}</span>
                                        <span><i class="fal fa-thumbs-up"></i> {{ .related.Prev.Favorite }}</span></p>
                                    {{if gt (len .related.Prev.Tags) 0}}
                                    <p class="mb-1 media-tag">
                                        <span>
                                            <i class="fal fa-tags"></i>
                                            {{ range $t := .related.Prev.Tags }}
                                                <a href="#">{{ $t.Tag }}</a>
                                            {{ end }}
                                        </span>
                                    </p>
                                    {{ end }}
                                </div>
                                {{ if .related.Prev.File.Path }}
                                    <img src="{{ $image }}{{ .related.Prev.File.Path }}" class="ml-3">
                                {{ end }}
                            </div>
                        </li>
                        {{ end }}

                        {{ if gt .related.Next.ID 0 }}
                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="/article/detail/{{ .related.Next.ID}}">{{ .related.Next.Title }}</a></h5>
                                    <p class="mb-1 media-summary">{{ .related.Next.Summary }}</p>
                                    <p class="mb-1 media-icon">
                                        <span><i class="fal fa-eye"></i> {{ .related.Next.Hit }}</span>
                                        <span><i class="fal fa-comments"></i> {{ .related.Next.Comment }}</span>
                                        <span><i class="fal fa-thumbs-up"></i> {{ .related.Next.Favorite }}</span></p>
                                    {{if gt (len .related.Next.Tags) 0}}
                                        <p class="mb-1 media-tag">
                                        <span>
                                            <i class="fal fa-tags"></i>
                                            {{ range $t := .related.Next.Tags }}
                                                <a href="#">{{ $t.Tag }}</a>
                                            {{ end }}
                                        </span>
                                        </p>
                                    {{ end }}
                                </div>
                                {{ if .related.Next.File.Path }}
                                    <img src="{{ $image }}{{ .related.Next.File.Path }}" class="ml-3">
                                {{ end }}
                            </div>
                        </li>
                        {{ end }}
                    </ul>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        全部评论
                    </h1>
                    <small class="text-black-50">Recommend</small>
                </div>

                <div class="mt-3" style="overflow:hidden">
                    <div class="media">
                        <img src="/public/image/logo.png" width="60px" style="border-radius:50%;border:1px solid #e4e4e4;margin-right:20px;">
                        <div class="media-body">
                            <textarea rows="4" style="width:100%;border:1px solid #e4e4e4"></textarea>
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-lg-3 content-right">
                <div class="card border-0 recommend">
                    {{ if gt .hot.ID 0}}
                        <img src="{{ $image }}{{ .hot.File.Path }}" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><a href="#">{{ .hot.Title }}</a></h5>
                            <p class="card-text">{{ .hot.Summary }}</p>
                        </div>
                    {{ end }}
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

            // 文章内容图片居中
            $("#article-content img").each(function(i,item){
                $(item).closest("p").css({"text-indent":0,"text-align":"center"})
            });

            // 操作条定位
            var bodyWidth = $("body").width();
            var containerWidth = $(".container").width();
            var actionWidth = $(".action").width();
            var left = (bodyWidth-containerWidth)/2 -actionWidth;
            $(".action").css({"left":left});
        });
    </script>
{{ end }}