// background
particlesJS.load('particles-js', '/public/plug-in/particles/particles.json', function() {
    //console.log('callback - particles.js config loaded');
});

// third platform login
$("#loginModal .modal-body a").on("click",function(e){
    let href = $(this).data('href');
    let redirect = encodeURIComponent(window.location.href);

    href += redirect.indexOf("?") >= 0? "&redirect="+redirect:"?redirect="+redirect;
    window.location.href = href;
    e.preventDefault();
});

// logout
$("#logout").on("click",function(e){
    let href = $(this).data('href');
    let redirect = encodeURIComponent(window.location.href);

    href += redirect.indexOf("?") >= 0? "&redirect="+redirect:"?redirect="+redirect;
    window.location.href = href;
    e.preventDefault();
});

// checkout login before comment
$("#comment-textarea").on("click",function(){
    $.get("/auth/user",{},function(result){
        if(result.user.base.id <= 0){
            $(".login-btn").trigger("click");
        }
    });
});

// back to top
$(".back-to-top").on("click",function(){
    $('body,html').animate({
        scrollTop: 0
    },500);
});