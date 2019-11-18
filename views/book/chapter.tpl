{{ define "css" }}
    <link rel="stylesheet" href="/public/plug-in/editor-md/css/editormd.min.css" />
{{ end }}

{{ define "content" }}
    <div class="container-fluid book-container">
        <div class="row">
            <div class="col-lg-3 mb-4">
                <div id="toc-catalogue-container" class="toc-container"></div>
                <div id="book-catalogue" style="display:none">
                    <textarea style="display:none;">{{ .bookChapter.Book.Catalogue}}</textarea>
                </div>
            </div>
            <div class="col-lg-6 mb-4">
                <div class="article-detail">
                    <h1 class="article-title text-center" data-book_name="{{ .bookChapter.Book.Name }}">{{ .bookChapter.Title}}</h1>
                    <div class="article-icon text-center">
                        <span><i class="fal fa-calendar-alt"></i> 发布时间 {{ .bookChapter.Book.CreatedAt.Format "2006/01/02"}}</span>
                    </div>

                    <div id="article-content" class="article-content">
                        <textarea style="display:none;">{{ .bookChapter.Chapter}}</textarea>
                    </div>
                </div>

                {{if .bookChapter.Tags}}
                    <div class="article-tips">
                        <i class="fal fa-tags"></i>
                        {{ range $v := .bookChapter.Tags }}
                            <a href="#">{{ $v.Name }}</a>
                        {{ end }}
                    </div>
                {{ end }}
                <div class="article-notice">
                    <p class="m-0"><i class="fal fa-info-circle-circle"></i> 转载请以<span class="text-primary">超链接形式</span>并注明出处。原文地址：<a class="text-primary" href="/book/chapter/{{ .bookChapter.ID}}">《{{ .bookChapter.Title}}》</a></p>
                </div>

                <div class="action-bar">
                    <div class="action-icon" title="有用">
                        <span class="fa-stack useful" data-model="{{ .model }}" data-model_id="{{ .bookChapter.ID }}" data-action="useful">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-thumbs-up fa-stack-1x fa-inverse"></i>
                        </span>
                        <b>{{if gt .bookChapter.Useful 99}}99+{{ else if gt .bookChapter.Useful 0}}{{ .bookChapter.Useful }}{{ end }}</b>
                    </div>
                    <div class="action-icon" title="评论">
                        <a class="hash-link" href="#comments">
                        <span class="fa-stack">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-comments-alt fa-stack-1x fa-inverse"></i>
                        </span>
                        </a>
                        <b>{{if gt .bookChapter.Comment 99}}99+{{ else if gt .bookChapter.Comment 0}}{{ .bookChapter.Comment}}{{ end }}</b>
                    </div>
                    <div class="action-icon" title="收藏">
                        <span class="fa-stack favorite" data-model="{{ .model }}" data-model_id="{{ .bookChapter.ID }}" data-action="favorite">
                          <i class="fa fa-circle fa-stack-2x"></i>
                          <i class="fal fa-star fa-stack-1x fa-inverse"></i>
                        </span>
                        <b>{{if gt .bookChapter.Favorite 99}}99+{{ else if gt .bookChapter.Favorite 0}}{{ .bookChapter.Favorite}}{{ end }}</b>
                    </div>
                    {{ if gt .related.Prev.ID 0 }}
                        <div class="action-icon" title="上一篇">
                            <a href="/book/chapter/{{ .related.Prev.ID}}">
                                <span class="fa-stack">
                                  <i class="fa fa-circle fa-stack-2x"></i>
                                  <i class="fal fa-chevron-left fa-stack-1x fa-inverse"></i>
                                </span>
                            </a>
                        </div>
                    {{ end }}
                    {{ if gt .related.Next.ID 0 }}
                        <div class="action-icon" title="下一篇">
                            <a href="/book/chapter/{{ .related.Next.ID}}">
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

                {{ template "comment" .}}

            </div>
            <div class="col-lg-3 mb-4">
                <div id="toc-chapter-container" class="toc-container"></div>
            </div>
        </div>
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
    <script src="/public/js/jquery.nicescroll.min.js"></script>
    <script src="/public/js/comment.js"></script>

    <script type="text/javascript">
        $(function() {
            // 书籍目录
            let bookCatalogue = editormd.markdownToHTML("book-catalogue", {
                htmlDecode      : "style,script,iframe",
                emoji           : true,
                taskList        : true,
                tex             : true,  // 默认不解析
                flowChart       : true,  // 默认不解析
                sequenceDiagram : true,  // 默认不解析
                toc: true,
                tocContainer:"#toc-catalogue-container",
                tocDropdown:true,
            });
            // 修改TOC的链接
            $("#book-catalogue a.reference-link").remove();
            $("#toc-catalogue-container a").each(function(i,item){
                $(item).attr("href",$("#book-catalogue a:eq("+i+")").attr("href"));
            });

            // 章节内容
            let chapterDetail = editormd.markdownToHTML("article-content", {
                htmlDecode      : "style,script,iframe",
                emoji           : true,
                taskList        : true,
                tex             : true,  // 默认不解析
                flowChart       : true,  // 默认不解析
                sequenceDiagram : true,  // 默认不解析
                toc: true,
                tocContainer:"#toc-chapter-container",
                tocDropdown:true,
            });
            $("#article-content").addClass("editormd-preview-theme-dark");

            // make image in article align center
            $("#article-content img").each(function(i,item){
                $(item).closest("p").css({"text-indent":0,"text-align":"center"})
            });

            let height = $(window).height()-$("nav.navbar").height()-$(".footer").height()-130;
            let width = $(".col-lg-3").width()-$(".action-bar").width();
            $("#toc-catalogue-container").css({"height":height+"px","width":width+"px"});
            $("#toc-chapter-container").css({"height":height+"px","width":$(".col-lg-3").width()+"px"});

            // 书籍菜单定位
            $("#toc-catalogue-container").prepend('<h4 style="padding-left:1rem;"> <i class="fal fa-bars"></i> '+$("h1.article-title").data("book_name")+'</h4>');
            $('#toc-catalogue-container').niceScroll({
                cursorcolor: "#6f42c1",
                cursoropacitymax: 1,
                touchbehavior: false,
                cursorwidth: "4px",
                cursorborder: "0",
                cursorborderradius: "4px",
                autohidemode: false
            });

            // 章节菜单定位
            $('#toc-chapter-container').niceScroll({
                cursorcolor: "#6f42c1",
                cursoropacitymax: 1,
                touchbehavior: false,
                cursorwidth: "4px",
                cursorborder: "0",
                cursorborderradius: "4px",
                autohidemode: false
            });

            // action-bar position
            let bodyWidth = $("body").width();
            let containerWidth = $(".article-detail").width();
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