{{ define "css" }}
    <link rel="stylesheet" href="/public/plug-in/editor-md/css/editormd.min.css" />
{{ end }}

{{ define "content" }}

    <div class="container sub-container" style="max-width:960px;">
        <div class="row">
            <div class="col-lg-12 content-left mb-4">
                <div class="article-detail">
                    <h1 class="article-title text-center" data-book_name="{{ .bookChapter.Book.Name }}">{{ .bookChapter.Title}}</h1>
                    <div class="article-icon text-center">
                        <span><i class="fal fa-calendar-alt"></i> 发布时间 {{ .bookChapter.Book.CreatedAt.Format "2006/01/02"}}</span>
                    </div>
                    <div id="toc-container" class="toc-container"></div>
                    <div id="book-catalogue" style="display:none">
                        <textarea style="display:none;">{{ .bookChapter.Book.Catalogue}}</textarea>
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
    <script src="/public/js/jquery.nicescroll.min.js"></script>

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
                tocContainer:"#toc-container",
                tocDropdown:true,
            });
            // 修改TOC的链接
            $("#book-catalogue a.reference-link").remove();
            $("#toc-container a").each(function(i,item){
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
            });
            $("#article-content").addClass("editormd-preview-theme-dark");

            //  菜单定位 显示与隐藏
            $("#toc-container").prepend('<h4 style="padding-left:1rem;"> <i class="fal fa-bars"></i> '+$("h1.article-title").data("book_name")+'</h4>');
            let bodyWidth = $("body").width();
            let containerWidth = $(".container").width() + 30;
            let tocWidth = $("#toc-container").width();
            let left = (bodyWidth-containerWidth)/2 -tocWidth;
            if(left > 0 && $(".container").offset().left - $("#toc-container").offset().left - left > 0) {
                let height = $(window).height()-$("nav.navbar").height()-80-144;
                $("#toc-container").css({"left": left,"height":height+"px"}).show();
                $('#toc-container').niceScroll({
                    cursorcolor: "#6f42c1",
                    cursoropacitymax: 1,
                    touchbehavior: false,
                    cursorwidth: "4px",
                    cursorborder: "0",
                    cursorborderradius: "4px",
                    autohidemode: false
                });
            }else{
                $("#toc-container").css({"position":"static","overflow-y":"auto","display":"block","border-left":"4px solid #6f42c1"});
            }
        });
    </script>
{{ end }}