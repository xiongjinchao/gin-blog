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
                        <span><i class="fal fa-calendar-alt"></i> 发布时间 {{ .article.CreatedAt.Format "2006/01/02"}}</span>
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
                    <p class="m-0"><i class="fal fa-info-circle-circle"></i> 转载请以<span class="text-primary">超链接形式</span>并注明出处。原文地址：<a class="text-primary" href="/article/detail/{{ .article.ID}}">《{{ .article.Title}}》</a></p>
                </div>

                <div class="action-bar">
                    <div class="action-icon" title="有用">
                        <span class="fa-stack useful" data-model="{{ .model }}" data-model_id="{{ .article.ID }}" data-action="useful">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-thumbs-up fa-stack-1x fa-inverse"></i>
                        </span>
                        <b>{{if gt .article.Useful 0}}{{ .article.Useful }}{{ else if gt .article.Useful 99}}99+{{ end }}</b>
                    </div>
                    <div class="action-icon" title="评论">
                        <a class="hash-link" href="#comments">
                        <span class="fa-stack">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-comments-alt fa-stack-1x fa-inverse"></i>
                        </span>
                        </a>
                        <b>{{if gt .article.Comment 0}}{{ .article.Comment}}{{ else if gt .article.Comment 99}}99+{{ end }}</b>
                    </div>
                    <div class="action-icon" title="收藏">
                        <span class="fa-stack favorite" data-model="{{ .model }}" data-model_id="{{ .article.ID }}" data-action="favorite">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-star fa-stack-1x fa-inverse"></i>
                        </span>
                        <b>{{if gt .article.Favorite 0}}{{ .article.Favorite}}{{ else if gt .article.Favorite 99}}99+{{ end }}</b>
                    </div>
                    {{ if gt .related.Prev.ID 0 }}
                        <div class="action-icon" title="上一篇">
                            <a href="/article/detail/{{ .related.Prev.ID}}">
                                <span class="fa-stack">
                                  <i class="fa fa-circle fa-stack-2x"></i>
                                  <i class="fal fa-chevron-left fa-stack-1x fa-inverse"></i>
                                </span>
                            </a>
                        </div>
                    {{ end }}
                    {{ if gt .related.Next.ID 0 }}
                        <div class="action-icon" title="下一篇">
                            <a href="/article/detail/{{ .related.Next.ID}}">
                                <span class="fa-stack">
                                  <i class="fa fa-circle fa-stack-2x"></i>
                                  <i class="fal fa-chevron-right fa-stack-1x fa-inverse"></i>
                                </span>
                            </a>
                        </div>
                    {{ end }}
                    <div class="action-icon">
                        <span class="fa-stack back-to-top">
                          <i class="fal fa-rocket fa-stack-1x"></i>
                        </span>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        相关 <i class="fal fa-coffee"></i> 推荐
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
                                    <h5 class="mt-0 mb-2"><a href="/article/detail/{{ .related.Prev.ID}}">{{ .related.Prev.Title }}</a></h5>
                                    <p class="mb-1 media-summary">{{ .related.Prev.Summary }}</p>
                                    <p class="mb-1 media-icon">
                                        <span><i class="fal fa-thumbs-up"></i> {{ .related.Prev.Useful }}</span>
                                        <span><i class="fal fa-comments-alt"></i> {{ .related.Prev.Comment }}</span>
                                        <span><i class="fal fa-star"></i> {{ .related.Prev.Favorite }}</span>
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
                                    <h5 class="mt-0 mb-2"><a href="/article/detail/{{ .related.Next.ID}}">{{ .related.Next.Title }}</a></h5>
                                    <p class="mb-1 media-summary">{{ .related.Next.Summary }}</p>
                                    <p class="mb-1 media-icon">
                                        <span><i class="fal fa-thumbs-up"></i> {{ .related.Next.Useful }}</span>
                                        <span><i class="fal fa-comments-alt"></i> {{ .related.Next.Comment }}</span>
                                        <span><i class="fal fa-star"></i> {{ .related.Next.Favorite }}</span>
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

                {{ template "comment" .}}


            </div>

            <div class="col-lg-3 content-right">

                {{ template "guess" .}}

                {{ template "tag" .}}

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
    <script src="/public/js/comment.js"></script>

    <script type="text/javascript">
        $(function() {
            // article content markdown to html
            let articleView = editormd.markdownToHTML("article-content", {
                htmlDecode      : "style,script,iframe",
                emoji           : true,
                taskList        : true,
                tex             : true,  // 默认不解析
                flowChart       : true,  // 默认不解析
                sequenceDiagram : true,  // 默认不解析
            });
            $("#article-content").addClass("editormd-preview-theme-dark");

            // make image in article align center
            $("#article-content img").each(function(i,item){
                $(item).closest("p").css({"text-indent":0,"text-align":"center"})
            });

            // action-bar position
            let bodyWidth = $("body").width();
            let containerWidth = $(".container").width();
            let actionWidth = $(".action-bar").width();
            let left = (bodyWidth-containerWidth)/2 -actionWidth;
            $(".action-bar").css({"left":left}).fadeIn();

            // submit action log in (action bar && comment list)
            $(".useful, .useless, .favorite").on("click",function(){
                let that = $(this);
                let data = {
                    "model":$(this).data("model"),
                    "model_id":$(this).data("model_id"),
                    "action":$(this).data("action")
                };
                $.get("/auth/user",{},function(result){
                    if(result.data.user.base.id <= 0){
                        $(".login-btn").trigger("click");
                    }else{
                        $.post("/passport/action-log/create", data, function(result){
                            if(result.code == 200) {
                                if (that.closest(".action-icon").length > 0) {
                                    // article action bar
                                    let total = result.data.total > 99 ? "99+" : result.data.total;
                                    that.closest(".action-icon").find("b").text(total);
                                } else {
                                    // comment list
                                    that.find("span").text(result.data.total);
                                }
                                alert("操作成功");
                            }else{
                                alert(result.message);
                            }
                        });
                    }
                });
            });
        });
    </script>
{{ end }}