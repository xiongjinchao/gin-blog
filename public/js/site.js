// 背景动画
particlesJS.load('particles-js', '/public/plug-in/particles/particles.json', function() {
    //console.log('callback - particles.js config loaded');
});

// 评论前先检查登录
$("#comment-textarea").on("click",function(){
    $.get("/auth/user",{},function(result){
        if(result.user.base.id <= 0){
            $(".login-btn").trigger("click");
        }
    });
});