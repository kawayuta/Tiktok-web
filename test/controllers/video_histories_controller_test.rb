require 'test_helper'

class VideoHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_history = video_histories(:one)
  end

  test "should get index" do
    get video_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_video_history_url
    assert_response :success
  end

  test "should create video_history" do
    assert_difference('VideoHistory.count') do
      post video_histories_url, params: { video_history: { user_official_id: @video_history.user_official_id } }
    end

    assert_redirected_to video_history_url(VideoHistory.last)
  end

  test "should show video_history" do
    get video_history_url(@video_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_video_history_url(@video_history)
    assert_response :success
  end

  test "should update video_history" do
    patch video_history_url(@video_history), params: { video_history: { user_official_id: @video_history.user_official_id } }
    assert_redirected_to video_history_url(@video_history)
  end

  test "should destroy video_history" do
    assert_difference('VideoHistory.count', -1) do
      delete video_history_url(@video_history)
    end

    assert_redirected_to video_histories_url
  end
end
