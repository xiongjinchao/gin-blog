{{ define "comment" }}
    <div id="comments" class="text-center mt-4">
        <div class="navy-line"></div>
        <h1 class="font-weight-light navy-title">
            全部 <i class="fal fa-comments-alt"></i> 评论
        </h1>
        <small class="text-black-50">Comments</small>
    </div>

    <div class="mt-3">
        <form id="comment-form">
            <div class="clearfix">
                <div class="pull-left comment-avatar">
                    {{if gt .user.User.ID 0}}
                        <img class="avatar" src="{{ if .user.UserAuth.Avatar }}{{ .user.UserAuth.Avatar }}{{ else }}/public/image/logo.png{{ end }}">
                        <a href="javascript:void(0)">{{ .user.User.Name }}</a>
                    {{ else }}
                        <img class="avatar" src="/public/image/logo.png">
                        <a href="javascript:void(0)">游客</a>
                    {{ end }}
                </div>
                <div class="pull-right"></div>
            </div>
            <div id="comment-textarea" class="mt-2">
                <textarea class="form-control" name="content" rows="2" placeholder="请文明发言" style="display:none"></textarea>
            </div>
            <div class="clearfix">
                <span class="pull-left badge badge-dark mr-1">Markdown</span>
                <span class="pull-left badge badge-dark">Code block</span>
                <input type="hidden" name="model" value="{{ .model }}">
                <input type="hidden" name="model_id" value="{{ .article.ID }}">
                <input type="hidden" name="root" value="0">
                <input type="hidden" name="parent" value="0">
                <button type="button" class="btn btn-sm btn-primary pull-right submit-comment"><i class="fal fa-paper-plane"></i> 发表</button>
            </div>
        </form>
    </div>

    <div class="comments">
        {{ $model := .model}}
        {{ $article := .article}}
        {{ range $i, $v := .comments }}
            <div class="mt-5 comment-parent">
                <div class="clearfix">
                    <div class="pull-left comment-avatar">
                        <img class="avatar" src="{{ if $v.UserAuth.Avatar }}{{ $v.UserAuth.Avatar }}{{ else }}/public/image/logo.png{{ end }}">
                        <a href="javascript:void(0)">{{ $v.User.Name }}</a>
                    </div>
                    <small class="text-muted pull-right"><i class="fal fa-clock"></i> {{ $v.CreatedAt.Format "2006/01/02" }}</small>
                </div>
                <div id="comment-{{ $i }}" class="comment-body">
                     <textarea style="display:none;">{{ $v.Content }}</textarea>
                </div>
                <div class="comment-tags text-muted" style="font-size:.875rem">
                    <i class="fal fa-chevron-up"></i> <a class="useful" data-model="comment" data-model_id="{{ $v.ID }}" data-action="useful" href="javascript:void(0)">赞 (<span>{{ $v.Useful }}</span>)</a>
                    <i class="fal fa-chevron-down"></i> <a class="useless" data-model="comment" data-model_id="{{ $v.ID }}" data-action="useless" href="javascript:void(0)">踩 (<span>{{ $v.Useless }}</span>)</a>
                    <i class="fal fa-comment-alt"></i> <a class="reply-comment" data-model="{{ $model }}" data-model_id="{{ $article.ID }}" data-root="{{ $v.ID }}" data-parent="{{ $v.ID }}" href="javascript:void(0)">回复</a>
                </div>

                <div class="comments-children" style="color:#999999">
                    {{ range $j, $c := $v.Children }}
                        <div class="media mt-2">
                        <div class="sub-comment-avatar">
                            <img class="avatar" src="{{ if $c.UserAuth.Avatar }}{{ $c.UserAuth.Avatar }}{{ else }}/public/image/logo.png{{ end }}">
                        </div>
                        <div class="media-body">
                            <a href="#">{{ $c.User.Name }}</a><a href="#" class="text-primary"> 回复 <i class="fas fa-at"></i>{{ $c.Father.User.Name }}</a>：
                            <small class="text-muted pull-right"><i class="fal fa-clock"></i>  {{ $c.CreatedAt.Format "2006/01/02" }}</small>
                            <div id="comment-{{$i}}-{{$j}}" class="comment-body">
                                <textarea style="display:none;">{{ $c.Content }}</textarea>
                            </div>
                            <div class="comment-tags text-muted" style="font-size:.875rem">
                                <i class="fal fa-chevron-up"></i> <a class="useful" data-model="comment" data-model_id="{{ $c.ID }}" data-action="useful" href="javascript:void(0)">赞 (<span>{{ $c.Useful }}</span>)</a>
                                <i class="fal fa-chevron-down"></i> <a class="useless" data-model="comment" data-model_id="{{ $c.ID }}" data-action="useless" href="javascript:void(0)">踩 (<span>{{ $c.Useless }}</span>)</a>
                                <i class="fal fa-comment-alt"></i> <a class="reply-comment" data-model="{{ $model }}" data-model_id="{{ $article.ID }}" data-root="{{ $v.ID }}" data-parent="{{ $c.ID }}" href="javascript:void(0)">回复</a>
                            </div>
                        </div>
                    </div>
                    {{ end }}
                </div>
            </div>
        {{ end}}
    </div>

    {{ if gt (len .pagination) 0}}
        <div class="row justify-content-center mt-4">
            <ul class="pagination pagination-sm">
                {{ range $v := .pagination }}
                    <li class="page-item {{ if $v.Active }}active{{ end }} {{ if $v.Disabled }}disabled{{ end }}"><a class="page-link" href="{{ $v.Url }}#comments">{{ $v.Label }}</a></li>
                {{ end }}
            </ul>
        </div>
    {{ end }}


    <!-- comment && reply modal -->
    <div class="modal fade" id="commentModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form id="comment-modal-form">
                    <div class="modal-header">
                        <h4 class="modal-title"><i class="fal fa-comment-alt"></i> 评论 / 回复</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <!-- append editor.md-->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-outline-primary submit-comment"><i class="fal fa-paper-plane"></i> 发表</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary" data-dismiss="modal"><i class="fal fa-ban"></i> 关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- comment && reply modal -->

{{ end }}