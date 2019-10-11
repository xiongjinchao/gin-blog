<!doctype html>
<html lang="zh-cn">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/public/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css">
    {{ template "css"}}
    <link rel="stylesheet" href="/public/css/site.css">
    <title>Susan's Blog golang 技术笔记</title>
</head>
<body>
    <div id="particles-js" class="site-background" style="position:absolute;width: 100%; height: 100%;left:0;right:0;top:0;bottom:0;z-index:0;"></div>
    {{ template "header" }}
    {{ template "content" .}}
    {{ template "footer" }}
    <!-- Mainly scripts -->
    <script src="/public/js/jquery-3.3.1.slim.min.js"></script>
    <script src="/public/js/popper.min.js"></script>
    <script src="/public/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <script src="/public/js/site.js"></script>

    {{ template "js"}}
</body>
</html>