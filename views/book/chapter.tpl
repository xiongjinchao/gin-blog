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
            let width = $(".col-lg-3").width();
            $("#toc-catalogue-container,#toc-chapter-container").css({"height":height+"px","width":width+"px"});

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

        });
    </script>
{{ end }}