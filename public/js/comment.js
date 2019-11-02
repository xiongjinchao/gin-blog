// father comment
$(".comments > .comment-parent").each(function(i,item){
    let commentView = editormd.markdownToHTML("comment-"+i, {
        htmlDecode      : "style,script,iframe",
        emoji           : true,
        taskList        : true,
        tex             : true,  // 默认不解析
        flowChart       : true,  // 默认不解析
        sequenceDiagram : true,  // 默认不解析
    });
    $("#comment-"+i).addClass("editormd-preview-theme-dark");
    //sub comment
    $(item).find(".comment-body").each(function(j,sub){
        let subView = editormd.markdownToHTML("comment-"+i+"-"+j, {
            htmlDecode      : "style,script,iframe",
            emoji           : true,
            taskList        : true,
            tex             : true,  // 默认不解析
            flowChart       : true,  // 默认不解析
            sequenceDiagram : true,  // 默认不解析
        });
        $("#comment-"+i+"-"+j).addClass("editormd-preview-theme-dark");
    });
});

// checkout login before reply comment
$(".reply-comment").on("click",function(){
    $(".reply-comment").removeClass("cur");
    $(this).addClass("cur");

    $.get("/auth/user",{},function(result){
        if(result.data.user.base.id <= 0){
            $(".login-btn").trigger("click");
        }else{
            $('#commentModal').modal('show');
        }
    });
});

// reply editor
$("#commentModal").on("shown.bs.modal",function(){
    let data = {
        "model":$(".reply-comment.cur").data("model"),
        "model_id":$(".reply-comment.cur").data("model_id"),
        "root":$(".reply-comment.cur").data("root"),
        "parent":$(".reply-comment.cur").data("parent"),
    };

    $("#commentModal .modal-body").empty().append("<div class=\"form-group\"><div id=\"reply-comment-textarea\"><textarea name=\"content\"></textarea></div></div>");
    let replyEditor = editormd("reply-comment-textarea", {
        width:"100%",
        height:"200",
        codeFold : true,
        htmlDecode : true,
        tex : true,
        taskList : true,
        emoji : true,
        flowChart : true,
        sequenceDiagram : true,
        watch: false,
        path: "/public/plug-in/editor-md/lib/",
        autoFocus: true,
        placeholder:"是时候展现真正的技术了！",
        toolbarIcons : function() {
            return ["undo", "redo", "bold", "quote", "hr", "h5", "h6", "list-ul", "list-ol","link", "code", "table", "||", "watch", "preview"]
        },
    });

    $.each(data, function(i, v){
        $('#commentModal .modal-body').append('<input type="hidden" name="'+i+'" value="'+v+'">');
    });
});

// comment editor
let commentEditor = editormd("comment-textarea", {
    width:"100%",
    height:"200",
    codeFold : true,
    htmlDecode : true,
    tex : true,
    taskList : true,
    emoji : true,
    flowChart : true,
    sequenceDiagram : true,
    watch:false,
    path:"/public/plug-in/editor-md/lib/",
    autoFocus: false,
    placeholder: "是时候展现真正的技术了！",
    toolbarIcons : function() {
        return ["undo", "redo", "bold", "quote", "hr", "h5", "h6", "list-ul", "list-ol","link", "code", "table", "||", "watch", "preview"]
    },
    onload: function () {
        //this.watch();
        //this.unwatch();
    }
});

// submit commit
$(".submit-comment").on("click",function(){
    let data = {};
    $.each($(this).closest("form").serializeArray(), function() {
        data[this.name] = this.value
    });

    $.post("/passport/comment/create", data, function(result){
        if(result.code == 200){
            alert("评论成功");
            window.location.reload()
        }else{
            alert(result.message);
        }
    });
});