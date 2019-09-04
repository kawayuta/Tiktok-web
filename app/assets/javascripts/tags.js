$(document).ready(function () {

  var next_v = $(".video_index_" + 0);
  $('.video_title').text(next_v.data('video-title'));
  $('.video_content_meta_tag').remove();
  $.each(next_v.data('video-tags'), function(index, value){
    $('.video_content_meta_tags').append('<p class="video_content_meta_tag">' +
      '<a href="/tags/search?keyword=' +
      value +
      '">#' +
      value +
      '</a>' +
      '<p>');
  });
  $('.video_play_count').text(next_v.data('video-play-count'));
  $('.video_comment_count').text(next_v.data('video-comment-count'));
  $('.video_share_count').text(next_v.data('video-share-count'));
  $('.video_user_covers img').attr('src', next_v.data('video-user-covers'));
  $('.video_user_covers img').attr('alt', next_v.data('video-user-nick-name'));
  $('.video_user_covers').attr('href', '/users/' + next_v.data('video-user-id'));
  $('.video_user_nick_name').text(next_v.data('video-user-nick-name'));

var video_index = 0;
var video = $('#video');
  for(var i=1;i<$(".video_data").length;i++){
    $('.swiper-wrapper').append('<div class="swiper-slide" style="height: 600px;">' +
      '<video muted="muted" controls="controls" id="video" class="video_' + i +'"playsinline="true" src="'+
      $(".video_index_" + i).data('video-source') +
      '" poster="' +
      $(".video_index_" + i).data('video-cover-image') + '"' +
      '">' +
      '</video>' +
      '</div>');
  }
video.attr('src', $(".video_index_0").data('video-source'));
video.load();
video.get(0).play();
$(".video_index_0").click();

  var ua = navigator.userAgent;
  if (ua.indexOf('iPhone') > 0 || ua.indexOf('Android') > 0 && ua.indexOf('Mobile') > 0) {
    // スマートフォン用コード
  } else if (ua.indexOf('iPad') > 0 || ua.indexOf('Android') > 0) {
    // タブレット用コード
  } else {

    for(var i=0;i<$(".video_data").length;i++){
      $('.video_' + i).prop('muted', false);
    }
  }

// video.on('ended',function(){
//   video_index += 1;
//   var next = $(".video_index_" + video_index);
//   video.attr('src', next.data('video-source'));
//   video.load();
//   video.get(0).play();
//
//   $('.video_title').text(next.data('video-title'));
//   $('.video_content_meta_tag').remove();
//   $.each(next.data('video-tags'), function(index, value){
//     $('.video_content_meta_tags').append('<p class="video_content_meta_tag">' +
//       '<a href="/tags/search?keyword=' +
//       value +
//       '">#' +
//       value +
//       '</a>' +
//       '<p>');
//   });
//   $('.video_play_count').text(next.data('video-play-count'));
//   $('.video_comment_count').text(next.data('video-comment-count'));
//   $('.video_share_count').text(next.data('video-share-count'));
//   $('.video_user_covers img').attr('src', next.data('video-user-covers'));
//   $('.video_user_covers').attr('href', '/users/' + next.data('video-user-id'));
//   $('.video_user_nick_name').text(next.data('video-user-nick-name'));
//
//   var item_width = $('.video_content_item ul li img')[0].width;
//   var item_margin_left = $('.video_content_item ul li img').css('margin-left').replace('px', '');
//   $('.video_content_item ul').animate({
//     scrollLeft: (item_width + Number(item_margin_left)) * (video_index + 1)
//   }, 500);
//
// });

// video.on('play',function(){
//   $('.video_player').animate({
//     "border-width": "1px",
//     "top": "-1px;",
//     "left": "-1px;"
//   }, 300).animate({
//     "top": "0px;",
//     "left": "0px;",
//     "border-width": "0px"
//   }, 100)
// });
//
$(".video_data").hover(function() {
  $(this).css({
    'transform': 'scale(1.1)'
  });

}, function() {
  $(this).css({
    'transform': 'scale(1)'
  });

});


$(".video_data").click(function(){

  var video = $('#video');
  video_index = $(this).data('video-index');
  swiper.slideTo(video_index);
  for(var i=0;i<$(".video_data").length;i++){
    $('.video_' + i).prop('muted', false);
  }

  $(this).animate({
    'transform': 'scale(1.1)'
  }, 300);

  $(this).animate({
    'transform': 'scale(1)'
  }, 300);

  var item_width = $('.video_content_item ul li img')[0].width;
  var item_margin_left = $('.video_content_item ul li img').css('margin-left').replace('px', '');
  $('.video_content_item ul').animate({
    scrollLeft: (item_width + Number(item_margin_left)) * (video_index + 1)
  }, 500);
});


  var swiper = new Swiper('.swiper-container', {
    direction: 'vertical',
    pagination: {
      clickable: false,
    }
  });
  var page = 0;

    swiper.on('touchStart', function () {
      for(var i=0;i<$(".video_data").length;i++){
        $('.video_' + i).prop('muted', false);
      }
    });

    swiper.on('slideChange', function () {
    if(page != swiper.realIndex) {
      $('.video_' + page).get(0).pause();
      page = swiper.realIndex;
      $('.video_' + page).get(0).load();
      $('.video_' + page).get(0).play();

      var next_v = $(".video_index_" + page);
      $('.video_title').text(next_v.data('video-title'));
      $('.video_content_meta_tag').remove();
      $.each(next_v.data('video-tags'), function(index, value){
        $('.video_content_meta_tags').append('<p class="video_content_meta_tag">' +
          '<a href="/tags/search?keyword=' +
          value +
          '">#' +
          value +
          '</a>' +
          '<p>');
      });
      $('.video_play_count').text(next_v.data('video-play-count'));
      $('.video_comment_count').text(next_v.data('video-comment-count'));
      $('.video_share_count').text(next_v.data('video-share-count'));
      $('.video_user_covers img').attr('src', next_v.data('video-user-covers'));
      $('.video_user_covers img').attr('alt', next_v.data('video-user-nick-name'));
      $('.video_user_covers').attr('href', '/users/' + next_v.data('video-user-id'));
      $('.video_user_nick_name').text(next_v.data('video-user-nick-name'));


      $('.video_' + page).on('ended',function(){
        var next = page + 1;
        swiper.slideTo(next);
      });

      var item_width = $('.video_content_item ul li img')[0].width;
      var item_margin_left = $('.video_content_item ul li img').css('margin-left').replace('px', '');
      $('.video_content_item ul').animate({
        scrollLeft: (item_width + Number(item_margin_left)) * (page + 1)
      }, 500);
    }
  });

  $('.video_' + page).on('ended',function(){
    var next = page + 1;
    swiper.slideTo(next);
  });



var hearts = {};
var heartIndex = 0;
var mouse = {};
var headerHeight = 60;

function Scene()
{
  this.canvas = document.createElement("canvas");
  this.context = this.canvas.getContext("2d");
}

Scene.prototype.init = function()
{
  var wrapper = document.getElementsByClassName('canvas_heart_bubble')[0];
  var style = this.canvas.style;
  style.background = 'transparent';
  style.height = headerHeight;
  wrapper.appendChild(this.canvas);
};

function Heart(canvas)
{
  this.scene = canvas;
  this.x = 340;
  this.y = 100;
  this.age = 0;
  this.currentScale = 0.1;
  this.maxScale = ~~(Math.random()*1) + 1;
  this.death = ~~(Math.random() * 50) + 100;
  this.speed = 0.8;
  this.angle = (Math.random() + 0.2) * Math.PI;
  heartIndex++;
  this.id = heartIndex;
  hearts[heartIndex] = this;
}

Heart.prototype.draw = function()
{
  // Wrong way to do it :D randomize Y each time
  // this.gravityY = (~~(Math.random() * 4) + 1) * (Math.floor(Math.random() - 0.5) === 0 ? 1 : -1);
  // this.gravityX = ~~(Math.random()) + 1;

  this.currentScale= this.currentScale > this.maxScale? this.maxScale : this.currentScale + 0.001;
  // this.y -= this.gravityY;
  // this.x += this.gravityX;

  // Less derpy way to do it, science bitches !
  this.x += Math.sin(this.angle) * this.speed;
  this.y += Math.cos(this.angle) * this.speed;
  this.age++;
  //Farewell my friend.
  if (this.age > this.death)
  {
    delete hearts[this.id];
  }

  var ctx = this.scene.context;
  var x = this.x,
    y = this.y;
  ctx.save(); // We're doing translate/scale, saving context state before
  ctx.translate(x/2, y/2);

  ctx.scale(this.currentScale,this.currentScale);
  ctx.beginPath();
  ctx.bezierCurveTo(75,37,70,25,50,25);
  ctx.bezierCurveTo(20,25,20,62.5,20,62.5);
  ctx.bezierCurveTo(20,80,40,102,75,120);
  ctx.bezierCurveTo(110,102,130,80,130,62.5);
  ctx.bezierCurveTo(130,62.5,130,25,100,25);
  ctx.bezierCurveTo(85,25,75,37,75,40);

  ctx.fillStyle = 'rgba(255,0,0,' + (1 - this.age/this.death) * 2 + ')';
  ctx.fill();
  ctx.restore();
  //console.log(this.id,' drawing. :)',this.x,this.y,this.currentScale,this.maxScale);
};

function run() {
  var h = scene.canvas.height;
  var w = scene.canvas.width;
  var ctx = scene.context;

  ctx.moveTo(0,0);
  ctx.setTransform(1, 0, 0, 1, 0, 0);
  ctx.clearRect(0, 0, w, h);

  // let's create some particles if needed
  var numHearts = Object.keys(hearts).length;
  if (numHearts < 10)
  {
    if (heartIndex === 0 || numHearts === 0)
    {
      new Heart(scene);
    }
    else if (numHearts > 0 && hearts[Object.keys(hearts).pop()].age > ~~(Math.random() * 20) + 40)
    {
      new Heart(scene);
    }

  }


  // and draw each one seperately
  //scene.context.clearRect(0,0,1280,150);
  for (var j in hearts) {
    hearts[j].draw();
  }
  // and run it over and over again
  requestAnimationFrame(run);
}


// init
var scene = new Scene();
scene.init();

function trackMouse(e) {
  mouse.x = e.pageX;
  mouse.y = e.pageY;
}

function forgetMouse(e) {
  mouse.x = false;
  mouse.y = false;
}

Scene.prototype.scale = function() {
};


function scaleCanvas() {
  scene.scale();
};
scaleCanvas();
run();

window.addEventListener('resize', scaleCanvas);


scene.canvas.addEventListener('mousemove', trackMouse);
scene.canvas.addEventListener('mouseleave', forgetMouse);



// Create a <div> that will be the bouncing
// ball.
function createBall(left, top, size, color) {
  return $('<div class="ball"></div>')
    .css("background-color", color)
    .css("left", left)
    .css("top", top)
    .css("width", size)
    .css("height", size)
    .css("border-radius", size / 2);
}

function getRandomColor() {
  return $.Color(getRandomInt(0, 255),
    getRandomInt(0, 255),
    getRandomInt(0, 255)).toHexString();
}

function getRandomBool() {
  return Math.random() >= 0.5;
}

function getRandomInt(min, max) {
  return min + Math.floor(Math.random() * (max - min));
}

function getRandomPath($container) {
  // First, we'll decide if the ball should
  // bounce from left to right or right to
  // left.
  var ltr = getRandomBool();

  // The diameter will range from 10 to 50 pixels.
  var size = getRandomInt(10, 50);

  // We'll return an object with parameters that
  // describe the ball and its bounce.
  return {
    color: getRandomColor(),
    size: size,
    left1: ltr ? -size : $container.width(),
    left2: getRandomInt(0, $container.width() - size),
    top: getRandomInt(-$container.height() * 2,
      $container.height() / 2 - size),
    duration: getRandomInt(500, 2000)
  }
}

// Bouncing a ball consists of horizontal and
// vertical animations that run simultaneously.
// (The second animation uses "queue: false".)
var count = 0;

function startBounceAnimation() {
  var $container = $("#container");
  var path = getRandomPath($container);
  var $div = $('.ball_' + count);
  count += 1;
  $div.animate({
    "left": path.left2
  }, {
    duration: path.duration,
    easing: 'swing'
  });
  $div.animate({
    "top": $container.height() - $div.height()
  }, {
    duration: path.duration,
    easing: 'easeOutBounce',
    queue: false
  });
  return $div;
}

// Once jQuery is ready, we bounce a ball and
// set a random timeout period to start the
// next bouncing ball.
$('.ball').each(function(){
  function bounceNextBall() {
    var $div = startBounceAnimation();
    setTimeout(bounceNextBall, getRandomInt(1, 1000));
  }
  bounceNextBall();
});



});
