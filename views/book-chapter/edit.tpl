{{ define "css" }}
    <link href="/public/inspinia/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
    <link href="/public/plug-in/editor-md/css/editormd.css" rel="stylesheet">
{{ end }}

{{ define "content" }}
    {{/*breadcrumbs*/}}
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>{{ .title}}</h2>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/admin/dashboard"><i class="fa fa-desktop"></i> 系统面板</a>
                </li>
                <li class="breadcrumb-item">
                    <i class="fa fa-gears"></i> 系统设置
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fa fa-bookmark"></i> 书籍章节</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-10">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>{{ .title }}</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项 1</a></li>
                                <li><a href="#">选项 2</a></li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form id="book-chapter-form" role="form" action="/admin/book-chapter/update/{{ .bookChapter.ID }}" method="post">
                            <div class="form-group">
                                <label class="font-bold">章节名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-user-o"></i>
                                    </span>
                                    <input type="text" name="title" placeholder="请输入章节名称" class="form-control" value="{{ .bookChapter.Title }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">所属书籍</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-th-list"></i>
                                    </span>
                                    <select class="form-control" name="book_id">
                                        <option value="0">请选择</option>
                                        {{$BookID := .bookChapter.BookID}}
                                        {{range .book}}
                                            <option value="{{.ID}}" {{if eq .ID $BookID}}selected{{end}}>{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">章节内容</label>
                                <div id="content">
                                    <textarea style="display:none" name="chapter" placeholder="" class="form-control" rows="12">{{ .bookChapter.Chapter }}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">点击量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-hand-o-up"></i>
                                    </span>
                                    <input type="text" name="hit" placeholder="" class="form-control" value="{{ .bookChapter.Hit }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">喜欢量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-heart-o"></i>
                                    </span>
                                    <input type="text" name="favorite" placeholder="" class="form-control" value="{{ .bookChapter.Favorite }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">评论量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-comment-o"></i>
                                    </span>
                                    <input type="text" name="comment" placeholder="" class="form-control" value="{{ .bookChapter.Comment }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">审核</label>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit1" value="1" {{if eq .bookChapter.Audit 1}}checked{{end}}>
                                    <label for="audit1">
                                        已审核
                                    </label>
                                </div>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit2" value="0" {{if eq .bookChapter.Audit 0}}checked{{end}}>
                                    <label for="audit2">
                                        未审核
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">排序</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-sort-amount-desc"></i>
                                    </span>
                                    <input type="text" name="sort" placeholder="" class="form-control" value="{{ .bookChapter.Sort }}">
                                </div>
                            </div>

                            <div>
                                <button class="btn btn-sm btn-primary" type="submit"> <i class="fa fa-paper-plane"></i> 保存</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{{ end }}

{{ define "js" }}
    <script src="/public/inspinia/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="/public/inspinia/js/plugins/validate/localization/messages_zh.js"></script>

    <script src="/public/plug-in/editor-md/editormd.min.js"></script>

    <script type="text/javascript">
        let editor = editormd("content", {
            width:"100%",
            height:"500",
            theme : "dark",
            previewTheme : "dark",
            editorTheme : "pastel-on-dark",
            codeFold : true,
            htmlDecode : true,
            tex : true,
            taskList : true,
            emoji : true,
            flowChart : true,
            sequenceDiagram : true,
            path:"/public/plug-in/editor-md/lib/"
        });

        $().ready(function() {
            $("#book-chapter-form").validate({
                rules: {
                    title: "required",
                    book_id: "required",
                    chapter: "required",
                    sort:{
                        digits:true
                    }
                },
                messages: {
                    title: "请输入章节名称",
                    book_id: "请选择书籍",
                    chapter: "请输入章节内容",
                    sort: {
                        digits: "排序值无效",
                    }
                }
            })
        });
    </script>
{{ end }}