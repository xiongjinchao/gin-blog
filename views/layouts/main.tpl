<!doctype html>
<html lang="zh-cn">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/public/css/bootstrap.min.css">
    <link href="/public/plug-in/fontawesome-pro-5.7.2/css/all.min.css" rel="stylesheet">
    {{ template "css"}}
    <link rel="stylesheet" href="/public/css/site.css">
    <title>{{.title}}</title>
</head>
<body>
    <div id="particles-js" class="site-bg"></div>
    {{ template "header" .}}
    {{ template "content" .}}
    {{ template "footer" .}}
    <!-- Mainly scripts -->
    <!--<script src="/public/js/jquery-3.3.1.slim.min.js"></script>-->
    <script src="http://cdn.staticfile.org/jquery/3.3.1/jquery.min.js"></script>
    <script src="/public/js/popper.min.js"></script>
    <!--<script src="/public/js/bootstrap.min.js"></script>-->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="/public/plug-in/particles/particles.min.js"></script>
    <script src="/public/js/site.js"></script>

    {{ template "js"}}
</body>
</html>