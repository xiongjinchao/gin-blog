{{ define "css" }}
    <link rel="stylesheet" href="/public/plug-in/editor-md/css/editormd.min.css" />
{{ end }}

{{ define "content" }}

    <div class="container sub-container">
        <div class="row">
            <div class="col-lg-12 content-left mb-4">
                <div class="article-detail">
                    <h1 class="article-title text-center">欢迎使用 Markdown</h1>
                    <div class="article-icon text-center">
                        <span><a href="#"><i class="fa fa-eye"></i> 520</a></span>
                        <span><a href="#"><i class="fa fa-comment-o"></i> 3</a></span>
                        <span><a href="#"><i class="fa fa-heart-o"></i> 100</a></span>
                        <span><i class="fa fa-clock-o"></i> 2019-10-01</span>
                    </div>
                    <div id="toc-container" class="toc-container"></div>
                    <div id="article-content" class="article-content">
                        <textarea style="display:none;"># 欢迎使用 Markdown

**Markdown是一种轻量级的「标记语言」**


![markdown](https://www.mdeditor.com/images/logos/markdown.png "markdown")


Markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。它允许人们使用易读易写的纯文本格式编写文档，然后转换成格式丰富的HTML页面，Markdown文件的后缀名便是“.md”


## MdEditor是一个在线编辑

*MdEditor扩展了Markdown的功能（如表格、脚注、内嵌HTML等等），以使让Markdown转换成更多的格式，和更丰富的展示效果，这些功能原初的Markdown尚不具备。*

> Markdown增强版中比较有名的有Markdown Extra、MultiMarkdown、 Maruku等。这些衍生版本要么基于工具，如~~Pandoc~~，Pandao；要么基于网站，如GitHub和Wikipedia，在语法上基本兼容，但在一些语法和渲染效果上有改动。

MdEditor源于Pandao的JavaScript开源项目，开源地址[Editor.md](https://github.com/pandao/editor.md "Editor.md")，并在MIT开源协议的许可范围内进行了优化，以适应广大用户群体的需求。向优秀的markdown开源编辑器原作者Pandao致敬。


![Pandao editor.md](https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png "Pandao editor.md")



## MdEditor的功能列表演示

# 标题H1

## 标题H2

### 标题H3

#### 标题H4

##### 标题H5

### 字符效果和横线等
----

~~删除线~~ <s>删除线（开启识别HTML标签时）</s>

*斜体字*      _斜体字_

**粗体**  __粗体__

***粗斜体*** ___粗斜体___

上标：X<sub>2</sub>，下标：O<sup>2</sup>

**缩写(同HTML的abbr标签)**
> 即更长的单词或短语的缩写形式，前提是开启识别HTML标签时，已默认开启

The <abbr title="Hyper Text Markup Language">HTML</abbr> specification is maintained by the <abbr title="World Wide Web Consortium">W3C</abbr>.
### 引用 Blockquotes

> 引用文本 Blockquotes

引用的行内混合 Blockquotes

> 引用：如果想要插入空白换行`即<br />标签`，在插入处先键入两个以上的空格然后回车即可，[普通链接](https://www.mdeditor.com/)。

### 锚点与链接 Links
[普通链接](https://www.mdeditor.com/)
[普通链接带标题](https://www.mdeditor.com/ "普通链接带标题")
直接链接：<https://www.mdeditor.com>
[锚点链接][anchor-id]
[anchor-id]: https://www.mdeditor.com/
[mailto:test.test@gmail.com](mailto:test.test@gmail.com)
GFM a-tail link @pandao
邮箱地址自动链接 test.test@gmail.com  www@vip.qq.com
> @pandao

### 多语言代码高亮 Codes

#### 行内代码 Inline code


执行命令：`npm install marked`

#### 缩进风格

即缩进四个空格，也做为实现类似 `<pre>` 预格式化文本 ( Preformatted Text ) 的功能。

    <?php
        echo "Hello world!";
    ?>
预格式化文本：

    | First Header  | Second Header |
    | ------------- | ------------- |
    | Content Cell  | Content Cell  |
    | Content Cell  | Content Cell  |

#### JS代码
```javascript
function test() {
	console.log("Hello world!");
}
```

#### HTML 代码 HTML codes
```html
<!DOCTYPE html>
<html>
    <head>
        <mate charest="utf-8" />
        <meta name="keywords" content="Editor.md, Markdown, Editor" />
        <title>Hello world!</title>
        <style type="text/css">
            body{font-size:14px;color:#444;font-family: "Microsoft Yahei", Tahoma, "Hiragino Sans GB", Arial;background:#fff;}
            ul{list-style: none;}
            img{border:none;vertical-align: middle;}
        </style>
    </head>
    <body>
        <h1 class="text-xxl">Hello world!</h1>
        <p class="text-green">Plain text</p>
    </body>
</html>
```
### 图片 Images

图片加链接 (Image + Link)：


[![](https://www.mdeditor.com/images/logos/markdown.png)](https://www.mdeditor.com/images/logos/markdown.png "markdown")

> Follow your heart.

----
### 列表 Lists

#### 无序列表（减号） (-)

- 列表一
- 列表二
- 列表三

#### 无序列表（星号） (*)

* 列表一
* 列表二
* 列表三

#### 无序列表（加号和嵌套）
+ 列表一
+ 列表二
    + 列表二-1
    + 列表二-2
    + 列表二-3
+ 列表三
    * 列表一
    * 列表二
    * 列表三

#### 有序列表  (-)

1. 第一行
2. 第二行
3. 第三行

#### GFM task list

- [x] GFM task list 1
- [x] GFM task list 2
- [ ] GFM task list 3
    - [ ] GFM task list 3-1
    - [ ] GFM task list 3-2
    - [ ] GFM task list 3-3
- [ ] GFM task list 4
    - [ ] GFM task list 4-1
    - [ ] GFM task list 4-2

----

### 绘制表格 Tables

| 项目        | 价格   |  数量  |
| --------   | -----:  | :----:  |
| 计算机      | $1600   |   5     |
| 手机        |   $12   |   12   |
| 管线        |    $1    |  234  |

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

| Function name | Description                    |
| ------------- | ------------------------------ |
| `help()`      | Display the help window.       |
| `destroy()`   | **Destroy your computer!**     |

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |
| zebra stripes | are neat        |    $1 |

| Item      | Value |
| --------- | -----:|
| Computer  | $1600 |
| Phone     |   $12 |
| Pipe      |    $1 |

----

#### 特殊符号

&copy; &  &uml; &trade; &iexcl; &pound;
&amp; &lt; &gt; &yen; &euro; &reg; &plusmn; &para; &sect; &brvbar; &macr; &laquo; &middot;

X&sup2; Y&sup3; &frac34; &frac14;  &times;  &divide;   &raquo;

18&ordm;C  &quot;  &apos;

[========]

### Emoji表情 :smiley:

> Blockquotes :star:

#### 反斜杠 Escape

\*literal asterisks\*

[========]
### 科学公式 TeX(KaTeX)

$$E=mc^2$$

行内的公式$$E=mc^2$$行内的公式，行内的$$E=mc^2$$公式。

$$x > y$$

$$\(\sqrt{3x-1}+(1+x)^2\)$$

$$\sin(\alpha)^{\theta}=\sum_{i=0}^{n}(x^i + \cos(f))$$

多行公式：

```math
\displaystyle
\left( \sum\_{k=1}^n a\_k b\_k \right)^2
\leq
\left( \sum\_{k=1}^n a\_k^2 \right)
\left( \sum\_{k=1}^n b\_k^2 \right)
```
```katex
\displaystyle
    \frac{1}{
        \Bigl(\sqrt{\phi \sqrt{5}}-\phi\Bigr) e^{
        \frac25 \pi}} = 1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {
        1+\frac{e^{-6\pi}}
        {1+\frac{e^{-8\pi}}
         {1+\cdots} }
        }
    }
```
```latex
f(x) = \int_{-\infty}^\infty
    \hat f(\xi)\,e^{2 \pi i \xi x}
    \,d\xi
```
### 分页符 Page break

> Print Test: Ctrl + P

[========]

### 绘制流程图 Flowchart

```flow
st=>start: 用户登陆
op=>operation: 登陆操作
cond=>condition: 登陆成功 Yes or No?
e=>end: 进入后台

st->op->cond
cond(yes)->e
cond(no)->op
```
[========]

### 绘制序列图 Sequence Diagram

```seq
Andrew->China: Says Hello
Note right of China: China thinks\nabout it
China-->Andrew: How are you?
Andrew->>China: I am good thanks!
```
### End

                        </textarea>
                    </div>
                </div>

                <div class="article-tips">
                    <i class="fa fa-tags"></i>
                    <a href="#">Golang</a> <a href="#">Slice</a>
                </div>
                <div class="article-notice">
                    <p class="m-0"><i class="fa fa-info-circle"></i> 未经允许不得转载：转载以<span class="text-primary">超链接形式</span>并注明出处。原文地址：<a class="text-primary" href="/article/detail/1">《【Golang】json自定义序列化的深入解析》</a></p>
                </div>

                <div class="text-center mt-4">
                    <div class="navy-line"></div>
                    <h1 class="font-weight-light navy-title">
                        相关推荐
                    </h1>
                    <small class="text-black-50">Recommend</small>
                </div>

                <div class="card border-0 mt-4 article-list">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="/article/detail/1">GCTT：Go中文翻译组成立了，期待大家的加入</a></h5>
                                    <p class="mb-1 media-summary">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                                    <p class="mb-1 media-icon"><span><i class="fa fa-eye"></i> 520</span> <span><i class="fa fa-comment"></i> 3</span> <span><i class="fa fa-heart"></i> 100</span></p>
                                </div>
                                <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/kaike.jpg" class="ml-3">
                            </div>
                        </li>

                        <li class="list-group-item">
                            <div class="media">
                                <div class="media-body">
                                    <h5 class="mt-0 mb-1"><a href="#">PHP与Golang如何通信</a></h5>
                                    <p class="mb-1 media-summary">又到了茶余饭后的时间，想想写点什么，掐指一算，噢呦，快到3月份了，职场的金三银四跳槽季又来了。</p>
                                    <p class="mb-1 media-icon"><span><i class="fa fa-eye"></i> 520</span> <span><i class="fa fa-comment"></i> 3</span> <span><i class="fa fa-heart"></i> 100</span></p>
                                </div>
                                <img src="http://www.daqianduan.com/wp-content/uploads/2019/07/kaike.jpg" class="ml-3">
                            </div>
                        </li>
                    </ul>
                </div>

            </div>
        </div>

        <div class="mt-5"></div>
    </div>

{{ end }}

{{ define "js" }}
    <script src="/public/plug-in/editor-md/lib/marked.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/prettify.min.js"></script>

    <script src="/public/plug-in/editor-md/lib/raphael.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/underscore.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/sequence-diagram.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/flowchart.min.js"></script>
    <script src="/public/plug-in/editor-md/lib/jquery.flowchart.min.js"></script>

    <script src="/public/plug-in/editor-md/editormd.js"></script>
    <script src="/public/js/jquery.nicescroll.min.js"></script>

    <script type="text/javascript">
        $(function() {
            // markdown 转 HTML
            var editormdView = editormd.markdownToHTML("article-content", {
                htmlDecode      : "style,script,iframe",  // you can filter tags decode
                emoji           : true,
                taskList        : true,
                tex             : true,  // 默认不解析
                flowChart       : true,  // 默认不解析
                sequenceDiagram : true,  // 默认不解析
                toc: true,
                tocContainer:"#toc-container",
                tocDropdown:true,
            });
            $("#article-content").addClass("editormd-preview-theme-dark");

            //  菜单定位 显示与隐藏
            $("#toc-container").prepend('<h4><i class=fa fa-puls></i> 目录</h4>');
            var bodyWidth = $("body").width();
            var containerWidth = $(".container").width() + 30;
            var tocWidth = $("#toc-container").width();
            var left = (bodyWidth-containerWidth)/2 -tocWidth;
            if(left > 0 && $(".container").offset().left - $("#toc-container").offset().left - left > 0) {
                var height = $(window).height()-$("nav.navbar").height()-35-144;
                $("#toc-container").css({left: left,height:height+"px"}).show();
                $('#toc-container').niceScroll({
                    cursorcolor: "#6f42c1",
                    cursoropacitymax: 1,
                    touchbehavior: false,
                    cursorwidth: "4px",
                    cursorborder: "0",
                    cursorborderradius: "4px",
                    autohidemode: false
                });
            }else{
                $("#toc-container").css({position:"static","overflow-y":"auto",display:"block","border-left":"4px solid #6f42c1"});
            }
        });
    </script>
{{ end }}