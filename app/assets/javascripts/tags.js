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

});
