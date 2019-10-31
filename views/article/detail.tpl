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
                        <span class="fa-stack">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-thumbs-up fa-stack-1x fa-inverse"></i>
                        </span>
                        <b>{{if gt .article.Favorite 0}}{{ .article.Favorite}}{{ else if gt .article.Favorite 99}}99+{{ end }}</b>
                    </div>
                    <div class="action-icon" title="评论">
                        <a href="#comment-textarea">
                        <span class="fa-stack">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-comments-alt fa-stack-1x fa-inverse"></i>
                        </span>
                        </a>
                        <b>{{if gt .article.Comment 0}}{{ .article.Comment}}{{ else if gt .article.Comment 99}}99+{{ end }}</b>
                    </div>
                    <div class="action-icon" title="收藏">
                        <span class="fa-stack">
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
                                    <h5 class="mt-0 mb-2"><a href="/article/detail/{{ .related.Prev.ID}}">{{ .related.Prev.Title }}</a></h5>
                                    <p class="mb-1 media-summary">{{ .related.Prev.Summary }}</p>
                                    <p class="mb-1 media-icon">
                                        <span><i class="fal fa-eye"></i> {{ .related.Prev.Hit }}</span>
                                        <span><i class="fal fa-comments-alt"></i> {{ .related.Prev.Comment }}</span>
                                        <span><i class="fal fa-chevron-up"></i> {{ .related.Prev.Favorite }}</span></p>
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
                                        <span><i class="fal fa-eye"></i> {{ .related.Next.Hit }}</span>
                                        <span><i class="fal fa-comments-alt"></i> {{ .related.Next.Comment }}</span>
                                        <span><i class="fal fa-chevron-up"></i> {{ .related.Next.Favorite }}</span></p>
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

                <div class="comments">

                    <div class="mt-3">
                        <div class="media">
                            <img class="avatar" src="/public/image/logo.png" width="52px">
                            <div class="media-body">
                                <div id="comment-textarea">
                                    <textarea rows="2" class="form-control" placeholder="请文明发言" style="display:none"></textarea>
                                </div>
                                <span class="pull-left badge badge-dark mr-1">Markdown</span>
                                <span class="pull-left badge badge-dark">Code</span>
                                <button class="btn btn-sm btn-primary pull-right"><i class="fal fa-paper-plane"></i> 发表</button>
                            </div>
                        </div>
                    </div>

                    <div class="media mt-5">
                        <img class="avatar" src="/public/image/avatar.jpg" width="52px">
                        <div class="media-body">
                            <a href="#">刘德华</a>
                            <small class="text-muted pull-right"><i class="fal fa-clock"></i> 3小数前</small>
                            <div id="comment-0" class="comment-body">
                                <textarea style="display:none;">但是正常的做法应该是这样的，同样的 ExecuteTemplate() 中输入的 name 也必须和模板中相同。

```go
func (*Template) Execute

func (t *Template) Execute(wr io.Writer, data interface{}) error

```
                                </textarea>
                            </div>
                            <div class="comment-tags text-muted" style="font-size:.875rem">
                                <i class="fal fa-chevron-up"></i> <a href="#">赞 (32)</a>
                                <i class="fal fa-chevron-down"></i> <a href="#">踩 (2)</a>
                                <i class="fal fa-comment-alt"></i> <a class="reply-comment" data-model="article" data-model-id="{{ .article.ID }}" data-root="0" data-parent="0" href="javascript:void(0)">回复</a>
                            </div>

                            <div class="comments-detail mt-5" style="color:#999999">
                                <div class="media mt-2">
                                    <img class="avatar" src="/public/image/avatar.jpg" width="42px">
                                    <div class="media-body">
                                        <a href="#">谢霆锋</a>
                                        <small class="text-muted pull-right"><i class="fal fa-clock"></i>  刚刚</small>
                                        <div id="comment-0-0" class="comment-body">
                                            <textarea style="display:none;">```go
func main() {
    s := []string{"hello", "world", "hello", "golang", "hello", "ruby", "php", "java"}
    fmt.Println(removeDuplicateElement(s))
}
```
                                            </textarea>
                                        </div>
                                        <div class="comment-tags text-muted" style="font-size:.875rem">
                                            <i class="fal fa-chevron-up"></i> <a href="#">赞 (32)</a>
                                            <i class="fal fa-chevron-down"></i> <a href="#">踩 (2)</a>
                                            <i class="fal fa-comment-alt"></i> <a class="reply-comment" data-model="article" data-model-id="{{ .article.ID }}" data-root="0" data-parent="0" href="javascript:void(0)">回复</a>
                                        </div>
                                    </div>
                                </div>

                                <div class="media mt-2">
                                    <img class="avatar" src="/public/image/avatar.jpg" width="42px">
                                    <div class="media-body">
                                        <a href="#">小刚</a>
                                        <small class="text-muted pull-right"><i class="fal fa-clock"></i>  5小数前</small>
                                        <div id="comment-0-1" class="comment-body">
                                            <textarea style="display:none;">在编写模板的时候，我们常常将公用的模板进行整合，比如每一个页面都有导航栏和页脚，我们常常将其编写为一个单独的模块，让所有的页面进行导入，这样就不用重复的编写了。</textarea>
                                        </div>
                                        <div class="comment-tags text-muted" style="font-size:.875rem">
                                            <i class="fal fa-chevron-up"></i> <a href="#">赞 (32)</a>
                                            <i class="fal fa-chevron-down"></i> <a href="#">踩 (2)</a>
                                            <i class="fal fa-comment-alt"></i> <a class="reply-comment" data-model="article" data-model-id="{{ .article.ID }}" data-root="0" data-parent="0" href="javascript:void(0)">回复</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="media mt-5">
                        <img class="avatar" src="/public/image/avatar.jpg" width="52px">
                        <div class="media-body">
                            <a href="#">张学友</a>
                            <small class="text-muted pull-right"><i class="fal fa-clock"></i>  2天前</small>
                            <div id="comment-1" class="comment-body">
                                <textarea style="display:none;">在编写模板的时候，我们常常将公用的模板进行整合，比如每一个页面都有导航栏和页脚，我们常常将其编写为一个单独的模块，让所有的页面进行导入，这样就不用重复的编写了。</textarea>
                            </div>
                            <div class="comment-tags text-muted" style="font-size:.875rem">
                                <i class="fal fa-chevron-up"></i> <a href="#">赞 (32)</a>
                                <i class="fal fa-chevron-down"></i> <a href="#">踩 (2)</a>
                                <i class="fal fa-comment-alt"></i> <a class="reply-comment" data-model="article" data-model-id="{{ .article.ID }}" data-root="0" data-parent="0" href="javascript:void(0)">回复</a>
                            </div>
                        </div>
                    </div>
                    <div class="media mt-5">
                        <img class="avatar" src="/public/image/avatar.jpg" width="52px">
                        <div class="media-body">
                            <a href="#">程序员</a>
                            <small class="text-muted pull-right"><i class="fal fa-clock"></i>  2天前</small>
                            <div id="comment-2" class="comment-body">
                                <textarea style="display:none;">&gt; 其实这都是一些基础问题，但是自己总是忘记，在这里做个记录。

```go
func main() {
    s := []string{"hello", "world", "hello", "golang", "hello", "ruby", "php", "java"}
    fmt.Println(removeDuplicateElement(s))
}

// output: 0xc4200160a0 0xc4200160a0
```

很明显了，就不解释了</textarea>
                            </div>
                            <div class="comment-tags text-muted" style="font-size:.875rem">
                                <i class="fal fa-chevron-up"></i> <a href="#">赞 (32)</a>
                                <i class="fal fa-chevron-down"></i> <a href="#">踩 (2)</a>
                                <i class="fal fa-comment-alt"></i> <a class="reply-comment" data-model="article" data-model-id="{{ .article.ID }}" data-root="0" data-parent="0" href="javascript:void(0)">回复</a>
                            </div>
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

    <!-- comment && reply modal -->
    <div class="modal fade" id="commentModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form id="comment-modal-form" action="/comment/create">
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fal fa-comment-alt"></i> 评论 / 回复</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <!-- append editor.md-->
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-sm btn-outline-primary"><i class="fal fa-paper-plane"></i> 发表</button>
                    <button type="button" class="btn btn-sm btn-outline-secondary" data-dismiss="modal">关闭</button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <!-- comment && reply modal -->

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
    <script src="/public/js/jquery.nicescroll.min.js"></script>

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

            // father comment
            $(".comments >.media").each(function(i,item){
                let commentView = editormd.markdownToHTML("comment-"+i, {
                    htmlDecode      : "style,script,iframe",
                    emoji           : true,
                    taskList        : true,
                    tex             : true,  // 默认不解析
                    flowChart       : true,  // 默认不解析
                    sequenceDiagram : true,  // 默认不解析
                });
                $("#comment-"+i).addClass("editormd-preview-theme-dark");
                //子评论
                $(item).find(".comment-body").each(function(j,sub){
                    let subView = editormd.markdownToHTML("comment-"+i+"-"+j, {
                        htmlDecode      : "style,script,iframe",
                        emoji           : true,
                        taskList        : true,
                        tex             : true,  // 默认不解析
                        flowChart       : true,  // 默认不解析
                        sequenceDiagram : true,  // 默认不解析
                    });
                    $("#comment-"+i+"-"+j).addClass("editormd-preview-theme-dark");
                });
            });

            // beautiful scroll
            $("pre.prettyprint ol").niceScroll({
                cursorcolor: "#6c757d",
                cursoropacitymax: 1,
                touchbehavior: false,
                cursorwidth: "4px",
                cursorborder: "0",
                cursorborderradius: "4px",
                autohidemode: false
            });

            // checkout login before reply comment
            $(".reply-comment").on("click",function(){
                $.get("/auth/user",{},function(result){
                    if(result.data.user.base.id <= 0){
                        $(".login-btn").trigger("click");
                    }else{
                        $('#commentModal').modal('show');
                    }
                });
            });

            // show editor in modal
            $("#commentModal").on("shown.bs.modal",function(){
                let data = {
                    "model":$(this).data("model"),
                    "model_id":$(this).data("model_id"),
                    "root":$(this).data("root"),
                    "parent":$(this).data("parent"),
                };

                $("#commentModal .modal-body").empty().append("<div class=\"form-group\"><div id=\"reply-comment-textarea\"></div></div>");
                let replyEditor = editormd("reply-comment-textarea", {
                    width:"100%",
                    height:"200",
                    codeFold : true,
                    htmlDecode : true,
                    tex : true,
                    taskList : true,
                    emoji : true,
                    flowChart : true,
                    sequenceDiagram : true,
                    watch: false,
                    path: "/public/plug-in/editor-md/lib/",
                    autoFocus: true,
                    placeholder:"是时候展现真正的技术了！",
                    toolbarIcons : function() {
                        return ["undo", "redo", "bold", "quote", "hr", "h5", "h6", "list-ul", "list-ol","link", "code", "table", "||", "watch", "preview"]
                    },
                });

                $.each(data,function(i,v){
                    $('#commentModal .modal-body').append('<input type="hidden" name="'+i+'" value="'+v+'">');
                });
            });

            // publish comment
            let commentEditor = editormd("comment-textarea", {
                width:"100%",
                height:"200",
                codeFold : true,
                htmlDecode : true,
                tex : true,
                taskList : true,
                emoji : true,
                flowChart : true,
                sequenceDiagram : true,
                watch:false,
                path:"/public/plug-in/editor-md/lib/",
                autoFocus: false,
                placeholder: "是时候展现真正的技术了！",
                toolbarIcons : function() {
                    return ["undo", "redo", "bold", "quote", "hr", "h5", "h6", "list-ul", "list-ol","link", "code", "table", "||", "watch", "preview"]
                },
                onload: function () {
                    //this.watch();
                    //this.unwatch();
                }
            });
        });
    </script>
{{ end }}