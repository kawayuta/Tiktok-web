
$(document).on('turbolinks:load', function() {
  var video_index = 0;
  var video = $('#video');
  video.attr('src', $(".video_data").data('video-source'));
  video.load();
  video.prop('muted', false);
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

});
