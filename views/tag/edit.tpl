{{ define "css" }}
    <link href="/public/inspinia/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
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
                    <i class="fa fa-th-large"></i> 基础数据
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fa fa-tags"></i> 标签管理</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-6">
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
                        <form id="tag-form" role="form" action="/admin/tag/update/{{ .tag.ID }}" method="post">

                            <div class="form-group">
                                <label class="font-bold">模型名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-th-list"></i>
                                    </span>
                                    <input type="text" name="model" placeholder="" class="form-control" value="{{ .tag.Model }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">模型编号</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-id-card"></i>
                                    </span>
                                    <input type="text" name="model_id" placeholder="" class="form-control" value="{{ .tag.ModelID }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">标签</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-tag"></i>
                                    </span>
                                    <input type="text" name="tag" placeholder="" class="form-control" value="{{ .tag.Tag }}">
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
    <script type="text/javascript">
        $().ready(function() {
            $("#tag-form").validate({
                rules: {
                    model:"required",
                    model_id: {
                        required: true,
                        digits:true
                    },
                    tag:"required",
                },
                messages: {
                    model: "请输入模型名称",
                    model_id: {
                        required: "请输入模型ID",
                        digits:"模型ID无效"
                    },
                    tag:"请输入标签",
                }
            })
        });
    </script>
{{ end }}