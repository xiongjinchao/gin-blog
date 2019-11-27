{{ define "css" }}
{{ end }}

{{ define "content" }}

<div class="container-fluid p-0">
    <div id="main-carousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#main-carousel" data-slide-to="0" class=""></li>
            <li data-target="#main-carousel" data-slide-to="1" class="active"></li>
            <li data-target="#main-carousel" data-slide-to="2" class=""></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item">
                <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
                    <defs>
                        <linearGradient id="line-gradient1" x1="0" x2="1" y1="0" y2="0">
                            <stop offset="0%" stop-color="#563d7c"/>
                            <stop offset="100%" stop-color="#020031"/>
                        </linearGradient>
                    </defs>
                    <rect width="100%" height="100%" fill="url(#line-gradient1)"></rect>
                </svg>
                <div class="container">
                    <div class="carousel-caption text-left">
                        <h1>Susan👸🏻's Blog</h1>
                        <p>使用gin框架开发的个人博客。后台整合了文章，分类，菜单，权限等功能模块</p>
                        <p>欢迎来github上拍dian砖zan</p>
                        <p><a class="btn btn-lg btn-primary" href="https://github.com/xiongjinchao/gin-blog" target="_blank" role="button"><i class="fab fa-github"></i> github</a></p>
                    </div>
                </div>
            </div>

            <div class="carousel-item active">
                <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
                    <linearGradient id="line-gradient2" x1="0" x2="1" y1="0" y2="0">
                        <stop offset="0%" stop-color="#020031"/>
                        <stop offset="100%" stop-color="#6d3353"/>
                    </linearGradient>
                    <rect width="100%" height="100%" fill="url(#line-gradient2)"></rect>
                </svg>
                <div class="container">
                    <div class="carousel-caption">
                        <h1>Susan👸🏻's Blog</h1>
                        <p>使用gin框架开发的个人博客。后台整合了文章，分类，菜单，权限等管理模块</p>
                        <p>欢迎来github上拍dian砖zan</p>
                        <p><a class="btn btn-lg btn-primary" href="https://github.com/xiongjinchao/gin-blog" target="_blank" role="button"><i class="fab fa-github"></i> github</a></p>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img">
                    <linearGradient id="line-gradient3" x1="0" x2="1" y1="0" y2="0">
                        <stop offset="0%" stop-color="#6d3353"/>
                        <stop offset="100%" stop-color="#563d7c"/>
                    </linearGradient>
                    <rect width="100%" height="100%" fill="url(#line-gradient3)"></rect>
                </svg>
                <div class="container">
                    <div class="carousel-caption text-right">
                        <h1>Susan👸🏻's Blog</h1>
                        <p>使用gin框架开发的个人博客。后台整合了文章，分类，菜单，权限等功能模块</p>
                        <p>欢迎来github上拍dian砖zan</p>
                        <p><a class="btn btn-lg btn-primary" href="https://github.com/xiongjinchao/gin-blog" target="_blank" role="button"><i class="fab fa-github"></i> github</a></p>
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#main-carousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#main-carousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>
<div class="container">
    <!-- Content here -->
    <div class="row mt-5">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1 class="font-weight-light navy-title">
                🍺Gin-Blog·技术栈
            </h1>
            <small class="text-black-50">Some technology used in Gin Blog. </small>
        </div>
    </div>
    <div class="card-group mt-3 technology">
        <div class="card border-info">
            <div class="card-header bg-transparent border-info text-center">
                Golang
            </div>
            <img src="/public/image/golang.jpg" class="card-img-top" alt="...">
            <div class="card-body bg-transparent border-info">
                <p class="card-text">Go是Google开发的一种静态强类型、编译型语言。</p>
            </div>
            <div class="card-footer bg-transparent border-info text-right">
                <small class="text-muted">version 1.13.1</small>
                <a href="https://golang.google.cn/dl/" target="_blank"><i class="fal fa-link"></i></a>
            </div>
        </div>
        <div class="card border-info">
            <div class="card-header bg-transparent border-info text-center">
                Gin 框架
            </div>
            <img src="/public/image/gin.jpg" class="card-img-top" alt="...">
            <div class="card-body border-info">
                <p class="card-text">Gin 是一个Go写的Web框架，具有高性能的优点。</p>
            </div>
            <div class="card-footer bg-transparent border-info text-right">
                <small class="text-muted">version 1.4.0</small>
                <a href="https://gin-gonic.com/" target="_blank"><i class="fal fa-link"></i></a>
            </div>
        </div>
        <div class="card border-info">
            <div class="card-header bg-transparent border-info text-center">
                MySQL 数据库
            </div>
            <img src="/public/image/mysql.jpg" class="card-img-top" alt="...">
            <div class="card-body">
                <p class="card-text">MySQL属于Oracle旗下，是最流行的关系型数据库管理系统之一。</p>
            </div>
            <div class="card-footer bg-transparent border-info text-right">
                <small class="text-muted">version 5.7</small>
                <a href="https://www.mysql.com/downloads/"><i class="fal fa-link"></i></a>
            </div>
        </div>
        <div class="card border-info">
            <div class="card-header bg-transparent border-info text-center">
                Bootstrap
            </div>
            <img src="/public/image/bootstrap.png" class="card-img-top" alt="...">
            <div class="card-body">
                <p class="card-text">Bootstrap是Twitter推出的一个用于前端开发的开源框架。</p>
            </div>
            <div class="card-footer bg-transparent border-info text-right">
                <small class="text-muted">version 4.3.1</small>
                <a href="https://getbootstrap.com/"><i class="fal fa-link"></i></a>
            </div>
        </div>
    </div>



    <div class="row mt-5">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1 class="font-weight-light  navy-title">
                优秀🐮资源
            </h1>
            <small class="text-black-50">Stand on daniel's shoulders.</small>
        </div>
    </div>

    <div class="card-group mt-3">
        <div class="card border-0 component">
            <ul class="list-group list-group-flush">
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-database"></i> Golang ORM</span>
                    <span><a href="https://github.com/jinzhu/gorm" target="_blank"><i class="fal fa-link"></i> https://github.com/jinzhu/gorm</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-address-card"></i> Golang ACL RBAC ABAC</span>
                    <span><a href="https://github.com/casbin/casbin" target="_blank"><i class="fal fa-link"></i> https://github.com/casbin/casbin</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-address-card"></i> Golang uuid</span>
                    <span><a href="https://github.com/satori/go.uuid" target="_blank">https://github.com/satori/go.uuid</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-user"></i> Golang JWT</span>
                    <span><a href="https://github.com/dgrijalva/jwt-go" target="_blank"><i class="fal fa-link"></i> https://github.com/dgrijalva/jwt-go</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-file-alt"></i> Gin Template</span>
                    <span><a href="https://github.com/foolin/gin-template" target="_blank"><i class="fal fa-link"></i> https://github.com/foolin/gin-template</a></span>
                </li>
            </ul>
        </div>
        <div class="card component component-image border-0 m-auto">
            <img src="/public/image/gin-admin.min.png" class="card-img-top" alt="...">
        </div>
        <div class="card border-0 component component-right">
            <ul class="list-group list-group-flush">
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-database"></i> Golang redis</span>
                    <span><a href="https://github.com/boj/redistore" target="_blank">https://github.com/boj/redistore</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-user"></i> Golang session</span>
                    <span><a href="https://github.com/gorilla/sessions" target="_blank">https://github.com/gorilla/sessions</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-cogs"></i> Golang ini config</span>
                    <span><a href="http://github.com/go-ini/ini" target="_blank">http://github.com/go-ini/ini</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-paper-plane"></i> govendor</span>
                    <span><a href="https://github.com/kardianos/govendor" target="_blank">https://github.com/kardianos/govendor</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title"><i class="fal fa-heartbeat"></i> validator</span>
                    <span><a href="https://gopkg.in/go-playground/validator.v9" target="_blank">https://gopkg.in/go-playground/validator.v9</a></span>
                </li>
            </ul>
        </div>
    </div>



    <div class="row mt-5">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1 class="font-weight-light navy-title">
                笔记🕸️杂谈
            </h1>
            <small class="text-black-50">The internet event.</small>
        </div>
    </div>
    <div class="card-group mt-3 article">
        <div class="card border-0">
            <ul class="list-group list-group-flush pr-lg-4">
                {{ range $v := .note }}
                    <li class="list-group-item border-0 clearfix"><a href="/article/detail/{{ $v.ID}}">{{ $v.Title }}</a><span class="card-time float-right text-black-50">{{ $v.CreatedAt.Format "2006/01/02" }}</span></li>
                {{ end }}
            </ul>
        </div>
        <div class="card border-0">
            <ul class="list-group list-group-flush pl-lg-4">
                {{ range $v := .article }}
                    <li class="list-group-item border-0"><a href="/article/detail/{{ $v.ID}}">{{ $v.Title }}</a><span class="card-time float-right text-black-50">{{ $v.CreatedAt.Format "2006/01/02" }}</span></li>
                {{ end }}
            </ul>
        </div>
    </div>



    <div class="row mt-5">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1 class="font-weight-light navy-title">
                中文📚手册
            </h1>
            <small class="text-black-50">Technical manual</small>
        </div>
    </div>

    <div class="card-group mt-3 book">
        <div class="card">
            <div class="card-body text-center">
                <a href="/book/detail/golang-simple-book"><img src="/public/image/golang.jpg" class="card-img-top" alt="..."></a></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="/book/detail/golang-gin"><img src="/public/image/gin.jpg" class="card-img-top" alt="..."></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="/book/detail/golang-gorm"><img src="/public/image/gorm.png" class="card-img-top" alt="gorm中文文档"></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="/book/detail/golang-lris"><img src="/public/image/lris.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="/book/detail/golang-web-application"><img src="/public/image/go-web.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="/book/detail/python"><img src="/public/image/python.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
    </div>
    <div class="card-group book">
        <div class="card">
            <div class="card-body text-center">
                <a href="/book/detail/git"><img src="/public/image/git.png" class="card-img-top" alt="..."></a></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="#"><img src="/public/image/bootstrap.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="#"><img src="/public/image/redis.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="#"><img src="/public/image/bootstrap.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="#"><img src="/public/image/redis.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <a href="#"><img src="/public/image/bootstrap.png" class="card-img-top" alt="..."></a>
            </div>
        </div>
    </div>

    <div class="m-5"></div>

</div>

{{ end }}

{{ define "js" }}
{{ end }}