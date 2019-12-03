{{ define "guess" }}

    <div class="card border-0 mb-4">
        <a href="https://promotion.aliyun.com/ntms/act/enterprise-discount.html?userCode=bgtvhz0i">
            <img src="https://img.alicdn.com/tfs/TB1Gc3zmAL0gK0jSZFxXXXWHVXa-259-194.jpg" class="card-img-top" style="border-radius:.25rem">
        </a>
    </div>

    <div class="text-center">
        <div class="navy-line"></div>
        <h1 class="font-weight-light navy-title">
            猜你 <i class="fal fa-heart"></i> 喜欢
        </h1>
        <small class="text-black-50">Favorite</small>
    </div>
    <div class="card border-0 mt-4 recommend">
        <ul class="list-group list-group-flush">
            {{ range $v := .recommend }}
                <li class="list-group-item"><a href="/article/detail/{{ $v.ID}}">{{ $v.Title }}</a><br/><span>阅读 {{ $v.Hit }}</span></li>
            {{ end }}
        </ul>
    </div>
{{ end }}