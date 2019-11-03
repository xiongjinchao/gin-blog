{{ define "tag" }}
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
{{ end }}