// background
particlesJS.load('particles-js', '/public/plug-in/particles/particles.json', function() {
    //console.log('callback - particles.js config loaded');
});

let LOCATION_HREF = window.location.href;
let LOCATION_URI = LOCATION_HREF.split('/');
console.log(LOCATION_URI);
//set active state menu
$("nav .dropdown-menu").each(function(i,dropdown){
    $(dropdown).find(".dropdown-item").each(function(j,item){
        console.log($(item).attr("href"));
    })
});

// third platform login
$("#loginModal .modal-body a").on("click",function(e){
    let href = $(this).data('href');
    let redirect = encodeURIComponent(LOCATION_HREF);

    href += redirect.indexOf("?") >= 0? "&redirect="+redirect:"?redirect="+redirect;
    window.location.href = href;
    e.preventDefault();
});

// logout
$("#logout").on("click",function(e){
    let href = $(this).data('href');
    let redirect = encodeURIComponent(LOCATION_HREF);

    href += redirect.indexOf("?") >= 0? "&redirect="+redirect:"?redirect="+redirect;
    window.location.href = href;
    e.preventDefault();
});

// checkout login before comment
$("#comment-textarea").on("click",function(){
    $.get("/auth/user",{},function(result){
        if(result.data.user.base.id <= 0){
            $(".login-btn").trigger("click");
        }
    });
});

// hash link animate
$("a.hash-link").on("click",function(e){
    let href = $(this).attr("href");
    $('html, body').animate({
        scrollTop: $(href).offset().top - $("nav.navbar").height()
    }, 500, function () {
        window.location.hash = href;
    });
    e.preventDefault();
});

// back to top
$(".back-to-top").on("click",function(){
    $('body,html').animate({
        scrollTop: 0
    },500);
});

// image link
$("a>img").each(function(i,item){
    $(item).closest("a").hover(function(){
       $(item).closest("a").css({"border":"0"})
    });
});