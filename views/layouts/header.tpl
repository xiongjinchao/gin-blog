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
                    <li class="nav-item active">
                        <a class="nav-link" href="/">首页 <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            笔记
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="/article/category/golang">Golang</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/article/category/mysql">MySQL</a>
                            <a class="dropdown-item" href="/article/category/redis">Redis</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/article/category/linux">Linux</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/article/category/talk-about">杂谈</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/book">技术手册</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/article/category/news">资讯</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/friend-link">优秀博客</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/collection">网址导航</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/about">Who is Susan?</a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="搜索..." aria-label="Search">
                    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit"><i class="fa fa-search"></i> 搜索</button>
                </form>
            </div>
        </nav>
    </div>
{{ end }}