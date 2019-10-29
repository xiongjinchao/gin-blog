{{ define "header" }}
    <div class="container-fluid p-0">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <a class="navbar-brand" href="#">
                🍺 Gin Blog
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="navbar-nav mr-auto">
                    {{ range $i, $v := .menu }}
                        {{if eq $v.Parent 0}}

                            {{if eq (len $v.Children) 0}}
                                <li class="nav-item {{if eq $i 0}}active{{ end }}">
                                    <a class="nav-link" href="{{$v.Tag}}">{{$v.Name}} <span class="sr-only">(current)</span></a>
                                </li>
                            {{else}}
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown{{$i}}" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        {{$v.Name}}
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown{{$i}}">
                                        {{ range $j, $c := $v.Children }}
                                            <a class="dropdown-item" href="{{ $c.Tag }}">{{$c.Name}}</a>
                                        {{ end }}
                                    </div>
                                </li>
                            {{ end }}

                        {{ end }}
                    {{ end }}

                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="搜索..." aria-label="Search">
                    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit"><i class="fal fa-search"></i> 搜索</button>
                    {{if gt .user.User.ID 0}}
                        <span class="dropdown has-login">
                            <img class="rounded-circle ml-2 avatar" src="{{ if .user.UerAuth.Avatar }}{{ .user.UerAuth.Avatar }}{{ else }}/public/image/logo.png{{ end }}" style="height:35px">
                            <a class="dropdown-toggle" href="" id="memberDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{{ .user.User.Name }}</a>
                            <div class="dropdown-menu" aria-labelledby="memberDropdown">
                                <a class="dropdown-item" href=""><i class="fal fa-home"></i> 我的主页</a>
                                <a class="dropdown-item" href=""><i class="fal fa-heart"></i> 喜欢的文章</a>
                                <a class="dropdown-item" href=""><i class="fal fa-cog"></i> 设置</a>
                                <a class="dropdown-item" href=""><i class="fal fa-sign-out"></i> 退出</a>
                            </div>
                        </span>
                    {{ else }}
                        <button class="btn btn-outline-info my-2 ml-2 my-sm-0 login-btn" type="button" data-toggle="modal" data-target="#loginModal"><i class="fal fa-user"></i> 登录</button>
                    {{ end }}
                </form>
            </div>
        </nav>
    </div>

    <!-- 登录模态框 -->
    <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">登录</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <p><a href="/auth/login/github"><i class="fab fa-github text-info" style="font-size:6rem;"></i></a></p>
                        <p style="font-size:.875rem;color:#999999;">更多登录方式敬请期待</p>
                        <p style="font-size:1.4rem;color:#6c757d">
                            <span class="fa-stack">
                              <i class="fa fa-circle fa-stack-2x"></i>
                              <i class="fa fa-qq fa-stack-1x fa-inverse"></i>
                            </span>
                            <span class="fa-stack">
                              <i class="fa fa-circle fa-stack-2x"></i>
                              <i class="fa fa-weibo fa-stack-1x fa-inverse"></i>
                            </span>
                            <span class="fa-stack">
                              <i class="fa fa-circle fa-stack-2x"></i>
                              <i class="fa fa-wechat fa-stack-1x fa-inverse"></i>
                            </span>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-outline-secondary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 登录模态框 -->

{{ end }}