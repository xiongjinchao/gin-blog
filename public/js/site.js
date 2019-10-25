// 背景动画
particlesJS.load('particles-js', '/public/plug-in/particles/particles.json', function() {
    //console.log('callback - particles.js config loaded');
});

// 登录信息
$(function(){
    $.get("/auth/passport",function(result){
        console.log(result);
        if(result.data.base.id > 0){
            $(".has-login > a > span").text(result.data.user.name);
            $(".has-login").show();
            $(".login-btn").hide();
        }else{
            $(".has-login").hide();
            $(".login-btn").show();
        }
    })
});