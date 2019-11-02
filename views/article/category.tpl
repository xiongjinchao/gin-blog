{{ define "css" }}
{{ end }}

{{ define "content" }}

    <div class="container sub-container">
        <div class="row">
            <div class="col-lg-9 content-left">
                <div class="banner">
                    <img style="width:100%;height:100%" src="http://www.daqianduan.com/wp-content/uploads/2017/09/tb-1.jpg" alt="">
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        {{ $len := len .breadcrumb }}
                        {{ range $i,$v := .breadcrumb }}
                            <span class="{{ if eq $v.active "1" }}active{{ end }}">{{ $v.label }}</span> {{ if lt (Add $i 1) $len}} / {{ end }}
                        {{ end }}
                    </h1>
                    <small class="text-black-50">{{ .category.Tag }}</small>
                </div>

                <div class="card border-0 mt-4 article-list">
                    <ul class="list-group list-group-flush">
                        {{ $image := .image }}
                        {{ range $v := .articles }}
                            <li class="list-group-item">
                                <div class="media">
                                    <div class="media-body">
                                        <h5 class="mt-0 mb-2"><a href="/article/detail/{{ $v.ID }}">{{ $v.Title }}</a></h5>
                                        <p class="mb-1 media-summary">{{ $v.Summary }}</p>
                                        <div class="clearfix">
                                            <p class="mb-1 media-icon">
                                                <span><i class="fal fa-eye"></i> {{ $v.Hit }}</span>
                                                <span><i class="fal fa-comments-alt"></i> {{ $v.Comment }}</span>
                                                <span><i class="fal fa-chevron-up"></i> {{ $v.Favorite }}</span>
                                            </p>
                                            {{if gt (len $v.Tags) 0}}
                                                <p class="mb-1 media-tag">
                                                    <span>
                                                        <i class="fal fa-tags"></i>
                                                        {{ range $t := $v.Tags }}
                                                            <a href="#">{{ $t.Tag }}</a>
                                                        {{ end }}
                                                    </span>
                                                </p>
                                            {{ end }}
                                        </div>
                                    </div>
                                    {{ if $v.File.Path }}
                                        <img src="{{ $image }}{{ $v.File.Path }}" class="ml-3">
                                    {{ end }}
                                </div>
                            </li>
                        {{ end }}
                    </ul>
                </div>

                {{ if gt (len .pagination) 0}}
                    <div class="row justify-content-center mt-4">
                        <ul class="pagination pagination-sm">
                            {{ range $v := .pagination }}
                                <li class="page-item {{ if $v.Active }}active{{ end }} {{ if $v.Disabled }}disabled{{ end }}"><a class="page-link" href="{{ $v.Url }}">{{ $v.Label }}</a></li>
                            {{ end }}
                        </ul>
                    </div>
                {{ end }}

            </div>
            <div class="col-lg-3 content-right">
                <div class="card border-0 about bg-dark">
                    <div class="card-body text-center">
                        <div>
                            <img class="rounded-circle mx-auto d-block avatar" src="/public/image/avatar.jpg">
                        </div>
                        <h5 class="card-title mt-2 mb-0">
                            Ted
                        </h5>
                        <small>PHPer & Gopher</small>
                        <p class="card-text mt-4">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                    </div>
                    <div class="card-footer bg-transparent text-center">
                        <span><a href="#"><i class="fal fa-envelope"></i> 邮箱</a></span>
                        <span><a href="#"><i class="fab fa-github"></i> github</a></span>
                        <span><a href="#"><i class="fab fa-qq"></i> QQ</a></span>
                    </div>
                </div>

                <div class="mt-4 text-center">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        猜你 <i class="fal fa-heart"></i> 喜欢
                    </h1>
                    <small class="text-black-50">Favorite</small>
                </div>

                <div class="card border-0 mt-4 recommend">
                    {{ if gt .hot.ID 0}}
                        <img src="{{ $image }}{{ .hot.File.Path }}" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><a href="#">{{ .hot.Title }}</a></h5>
                            <p class="card-text">{{ .hot.Summary }}</p>
                        </div>
                    {{ end }}
                    <ul class="list-group list-group-flush">
                        {{ range $v := .recommend }}
                            <li class="list-group-item"><a href="/article/detail/{{ $v.ID}}">{{ $v.Title }}</a><br/><span>阅读 {{ $v.Hit }}</span></li>
                        {{ end }}
                    </ul>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        热门 <i class="fal fa-tags"></i> 标签
                    </h1>
                    <small class="text-black-50">Tags</small>
                </div>

                <div class="card border-0 mt-4 tag">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><a href="#">PHP(120)</a></li>
                        <li class="list-group-item"><a href="#">Golang(800)</a></li>
                        <li class="list-group-item"><a href="#">MySQL(10)</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="mt-5"></div>
    </div>

{{ end }}

{{ define "js" }}
{{ end }}