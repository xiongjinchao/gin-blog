{{ define "guess" }}
    <div class="text-center">
        <div class="navy-line"></div>
        <h1 class="font-weight-light navy-title">
            猜你 <i class="fal fa-heart"></i> 喜欢
        </h1>
        <small class="text-black-50">Favorite</small>
    </div>
    <div class="card border-0 mt-4 recommend">
        {{ if gt .hot.ID 0}}
            <img src="{{ .image }}{{ .hot.File.Path }}" class="card-img-top" alt="...">
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
{{ end }}