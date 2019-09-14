require 'test_helper'

class TagInflowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_inflow = tag_inflows(:one)
  end

  test "should get index" do
    get tag_inflows_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_inflow_url
    assert_response :success
  end

  test "should create tag_inflow" do
    assert_difference('TagInflow.count') do
      post tag_inflows_url, params: { tag_inflow: { tag: @tag_inflow.tag, youtube: @tag_inflow.youtube } }
    end

    assert_redirected_to tag_inflow_url(TagInflow.last)
  end

  test "should show tag_inflow" do
    get tag_inflow_url(@tag_inflow)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_inflow_url(@tag_inflow)
    assert_response :success
  end

  test "should update tag_inflow" do
    patch tag_inflow_url(@tag_inflow), params: { tag_inflow: { tag: @tag_inflow.tag, youtube: @tag_inflow.youtube } }
    assert_redirected_to tag_inflow_url(@tag_inflow)
  end

  test "should destroy tag_inflow" do
    assert_difference('TagInflow.count', -1) do
      delete tag_inflow_url(@tag_inflow)
    end

    assert_redirected_to tag_inflows_url
  end
end
