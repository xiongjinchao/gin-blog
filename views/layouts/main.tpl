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
    {{ template "header" }}
    {{ template "content" .}}
    {{ template "footer" }}

    <!-- Mainly scripts -->
    <script src="/public/js/jquery-3.3.1.slim.min.js"></script>
    <script src="/public/js/popper.min.js"></script>
    <script src="/public/js/bootstrap.min.js"></script>
    <script src="/public/js/site.js"></script>

    {{ template "js"}}
</body>
</html>