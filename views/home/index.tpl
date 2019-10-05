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
                    <h1>Susan👸🏻 个人博客</h1>
                    <p>使用gin框架开发的个人博客。后台整合了文章，分类，菜单，权限等功能模块</p>
                    <p>欢迎来github上拍dian砖zan</p>
                    <p><a class="btn btn-lg btn-primary" href="https://github.com/xiongjinchao/gin-blog" target="_blank" role="button"><i class="fa fa-github"></i> github</a></p>
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
                    <h1>Susan👸🏻 个人博客</h1>
                    <p>使用gin框架开发的个人博客。后台整合了文章，分类，菜单，权限等管理模块</p>
                    <p>欢迎来github上拍dian砖zan</p>
                    <p><a class="btn btn-lg btn-primary" href="https://github.com/xiongjinchao/gin-blog" target="_blank" role="button"><i class="fa fa-github"></i> github</a></p>
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
                    <h1>Susan👸🏻 个人博客</h1>
                    <p>使用gin框架开发的个人博客。后台整合了文章，分类，菜单，权限等功能模块</p>
                    <p>欢迎来github上拍dian砖zan</p>
                    <p><a class="btn btn-lg btn-primary" href="https://github.com/xiongjinchao/gin-blog" target="_blank" role="button"><i class="fa fa-github"></i> github</a></p>
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
    <div class="card-group mt-3">
        <div class="card border-info">
            <div class="card-header bg-transparent border-info text-center">
                Golang
            </div>
            <img src="/public/image/golang.jpg" class="card-img-top" alt="...">
            <div class="card-body bg-transparent border-info">
                <p class="card-text">Go是Google开发的一种静态强类型、编译型语言。</p>
            </div>
            <div class="card-footer bg-transparent border-info text-right">
                <small class="text-muted">Version 1.13.1</small>
                <a href="https://golang.google.cn/dl/" target="_blank"><i class="fa fa-link"></i></a>
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
                <small class="text-muted">Version1.4.0</small>
                <a href="https://gin-gonic.com/" target="_blank"><i class="fa fa-link"></i></a>
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
                <small class="text-muted">Version 5.7</small>
                <a href="https://www.mysql.com/downloads/"><i class="fa fa-link"></i></a>
            </div>
        </div>
        <div class="card border-info">
            <div class="card-header bg-transparent border-info text-center">
                Bootstrap
            </div>
            <img src="/public/image/bootstrap.jpg" class="card-img-top" alt="...">
            <div class="card-body">
                <p class="card-text">Bootstrap是Twitter推出的一个用于前端开发的开源工具包，是一个前端框架。</p>
            </div>
            <div class="card-footer bg-transparent border-info text-right">
                <small class="text-muted">Version 4.3.1</small>
                <a href="https://getbootstrap.com/"><i class="fa fa-link"></i></a>
            </div>
        </div>
    </div>



    <div class="row mt-5">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1 class="font-weight-light  navy-title">
                站在大牛🐮的肩膀上
            </h1>
            <small class="text-black-50">Stand on daniel's shoulders.</small>
        </div>
    </div>

    <div class="card-group article mt-3">
        <div class="card border-0">
            <ul class="list-group list-group-flush">
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Golang ORM</span>
                    <span><a href="https://github.com/jinzhu/gorm" target="_blank">https://github.com/jinzhu/gorm</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Golang ACL RBAC ABAC</span>
                    <span><a href="https://github.com/casbin/casbin" target="_blank">https://github.com/casbin/casbin</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Golang uuid</span>
                    <span><a href="https://github.com/satori/go.uuid" target="_blank">https://github.com/satori/go.uuid</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Golang JWT</span>
                    <span><a href="https://github.com/dgrijalva/jwt-go" target="_blank">https://github.com/dgrijalva/jwt-go</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Gin Template</span>
                    <span><a href="https://github.com/foolin/gin-template" target="_blank">https://github.com/foolin/gin-template</a></span>
                </li>
            </ul>
        </div>
        <div class="card border-0">
            <ul class="list-group list-group-flush">
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Golang redis</span>
                    <span><a href="https://github.com/boj/redistore" target="_blank">https://github.com/boj/redistore</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Golang session</span>
                    <span><a href="https://github.com/gorilla/sessions" target="_blank">https://github.com/gorilla/sessions</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">Golang ini config</span>
                    <span><a href="http://github.com/go-ini/ini" target="_blank">http://github.com/go-ini/ini</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">govendor</span>
                    <span><a href="https://github.com/kardianos/govendor" target="_blank">https://github.com/kardianos/govendor</a></span>
                </li>
                <li class="list-group-item border-0">
                    <span class="d-block github-title">validator</span>
                    <span><a href="https://gopkg.in/go-playground/validator.v9" target="_blank">https://gopkg.in/go-playground/validator.v9</a></span>
                </li>
            </ul>
        </div>
    </div>



    <div class="row mt-5">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1 class="font-weight-light navy-title">
                互联网🕸️那点事
            </h1>
            <small class="text-black-50">The internet event.</small>
        </div>
    </div>
    <div class="card-group article mt-3">
        <div class="card border-0">
            <ul class="list-group list-group-flush">
                <li class="list-group-item border-0"><a href="#">我的 Go 语言学习之路</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">Go中文翻译组成立了，期待大家的加入</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">为什么80%的码农都做不了架构师？</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">架构师应该如何判断技术演进的方向？</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">为什么80%的码农都做不了架构师？</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">我的 Go 语言学习之路</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">Go中文翻译组成立了，期待大家的加入</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">为什么80%的码农都做不了架构师？</a><span class="float-right text-black-50">2019/10/01</span></li>
            </ul>
        </div>
        <div class="card border-0">
            <ul class="list-group list-group-flush">
                <li class="list-group-item border-0"><a href="#">我的 Go 语言学习之路</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">Go中文翻译组成立了，期待大家的加入</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">为什么80%的码农都做不了架构师？</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">架构师应该如何判断技术演进的方向？</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">为什么80%的码农都做不了架构师？</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">我的 Go 语言学习之路</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">Go中文翻译组成立了，期待大家的加入</a><span class="float-right text-black-50">2019/10/01</span></li>
                <li class="list-group-item border-0"><a href="#">为什么80%的码农都做不了架构师？</a><span class="float-right text-black-50">2019/10/01</span></li>
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

    <div class="card-group mt-3">
        <div class="card border-info">
            <div class="card-body bg-transparent border-bottom border-info text-center">
                <img src="/public/image/gorm.png" class="card-img-top" alt="gorm中文文档">
            </div>
            <div class="card-body bg-transparent text-center">
                <img src="/public/image/golang.jpg" class="card-img-top" alt="...">
            </div>
        </div>
        <div class="card border-info">
            <div class="card-body bg-transparent border-bottom border-info text-center">
                <img src="/public/image/gin.png" class="card-img-top" alt="...">
            </div>
            <div class="card-body bg-transparent text-center">
                <img src="/public/image/gin.jpg" class="card-img-top" alt="...">
            </div>
        </div>
        <div class="card border-info">
            <div class="card-body bg-transparent border-bottom border-info text-center">
                <img src="/public/image/mysql.jpg" class="card-img-top" alt="...">
            </div>
            <div class="card-body bg-transparent text-center">
                <img src="/public/image/mysql.jpg" class="card-img-top" alt="...">
            </div>
        </div>
        <div class="card border-info">
            <div class="card-body bg-transparent border-bottom border-info text-center">
                <img src="/public/image/bootstrap.jpg" class="card-img-top" alt="...">
            </div>
            <div class="card-body bg-transparent text-center">
                <img src="/public/image/bootstrap.jpg" class="card-img-top" alt="...">
            </div>
        </div>
        <div class="card border-info">
            <div class="card-body bg-transparent border-bottom border-info text-center">
                <img src="/public/image/bootstrap.jpg" class="card-img-top" alt="...">
            </div>
            <div class="card-body bg-transparent text-center">
                <img src="/public/image/bootstrap.jpg" class="card-img-top" alt="...">
            </div>
        </div>
    </div>

    <div class="m-5"></div>

</div>

{{ end }}

{{ define "js" }}
{{ end }}