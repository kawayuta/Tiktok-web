
$(document).on('turbolinks:load', function() {
  var video_index = 0;
  var video = $('#video');
  video.attr('src', $(".video_data").data('video-source'));
  video.load();
  video.prop('muted', true);
  video.get(0).play();
  video.on('ended',function(){
    video_index += 1;
    var next = $(".video_index_" + video_index);
    video.attr('src', next.data('video-source'));
    video.load();
    video.get(0).play();

    $('.video_title').text(next.data('video-title'));
    $('.video_content_meta_tag').remove();
    $.each(next.data('video-tags'), function(index, value){
      $('.video_content_meta_tags').append('<p class="video_content_meta_tag">' +
        '<a href="/tags/search?keyword=' +
        value +
        '">#' +
        value +
        '</a>' +
        '<p>');
    });
    $('.video_play_count').text(next.data('video-play-count'));
    $('.video_comment_count').text(next.data('video-comment-count'));
    $('.video_share_count').text(next.data('video-share-count'));
    $('.video_user_covers').attr('src', next.data('video-user-covers'));
    $('.video_user_nick_name').text(next.data('video-user-nick-name'));

    $('.video_content_item ul').animate({
      scrollLeft: 160 * (video_index + 1)
    }, 300);

  });

  video.on('play',function(){
    $('.video_player').animate({
      "border-width": "1px",
      "top": "-1px;",
      "left": "-1px;"
    }, 300).animate({
      "top": "0px;",
      "left": "0px;",
      "border-width": "0px"
    }, 100)
  });

  $(".video_data").hover(function() {
    $(this).css({
      'width': 'calc(140px * 1.1)',
      'height': 'calc(245px * 1.1)',
      "top": "calc(-1 * calc(140px * 0.05))",
    });

  }, function() {
    $(this).css({
      'width': 'calc(140px * 1)',
      'height': 'calc(245px * 1)',
      "top": "calc(140px * 0)",
    });

  });


  $(".video_data").click(function(){

    var video = $('#video');
    video_index = $(this).data('video-index');
    var next = $(".video_index_" + video_index);
    video.attr('src', $(this).data('video-source'));
    video.load();
    video.get(0).play();
    video.prop('muted', false);

    $('.video_title').text(next.data('video-title'));
    $('.video_content_meta_tag').remove();
    $.each(next.data('video-tags'), function(index, value){
      $('.video_content_meta_tags').append('<p class="video_content_meta_tag">' +
        '<a href="/tags/search?keyword=' +
        value +
        '">#' +
        value +
        '</a>' +
        '<p>');
    });
    $('.video_play_count').text(next.data('video-play-count'));
    $('.video_comment_count').text(next.data('video-comment-count'));
    $('.video_share_count').text(next.data('video-share-count'));
    $('.video_user_covers').attr('src', next.data('video-user-covers'));
    $('.video_user_nick_name').text(next.data('video-user-nick-name'));


    $(this).animate({
      "width": "340px",
      "height": "600px",
      "top": "-200px"
    }, 300);

    $(this).animate({
      "width": "140px",
      "height": "250px",
      "top": "0px"
    }, 300);

    $('.video_content_item ul').animate({
      scrollLeft: 160 * (video_index + 1)
    }, 500);
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

});
