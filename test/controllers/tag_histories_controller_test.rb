require 'test_helper'

class TagHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_history = tag_histories(:one)
  end

  test "should get index" do
    get tag_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_history_url
    assert_response :success
  end

  test "should create tag_history" do
    assert_difference('TagHistory.count') do
      post tag_histories_url, params: { tag_history: { user_nick_named: @tag_history.user_nick_named, user_official_id: @tag_history.user_official_id } }
    end

    assert_redirected_to tag_history_url(TagHistory.last)
  end

  test "should show tag_history" do
    get tag_history_url(@tag_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_history_url(@tag_history)
    assert_response :success
  end

  test "should update tag_history" do
    patch tag_history_url(@tag_history), params: { tag_history: { user_nick_named: @tag_history.user_nick_named, user_official_id: @tag_history.user_official_id } }
    assert_redirected_to tag_history_url(@tag_history)
  end

  test "should destroy tag_history" do
    assert_difference('TagHistory.count', -1) do
      delete tag_history_url(@tag_history)
    end

    assert_redirected_to tag_histories_url
  end
end
