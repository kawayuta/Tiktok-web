require "application_system_test_case"

class VideoHistoriesTest < ApplicationSystemTestCase
  setup do
    @video_history = video_histories(:one)
  end

  test "visiting the index" do
    visit video_histories_url
    assert_selector "h1", text: "Video Histories"
  end

  test "creating a Video history" do
    visit video_histories_url
    click_on "New Video History"

    fill_in "User official", with: @video_history.user_official_id
    click_on "Create Video history"

    assert_text "Video history was successfully created"
    click_on "Back"
  end

  test "updating a Video history" do
    visit video_histories_url
    click_on "Edit", match: :first

    fill_in "User official", with: @video_history.user_official_id
    click_on "Update Video history"

    assert_text "Video history was successfully updated"
    click_on "Back"
  end

  test "destroying a Video history" do
    visit video_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Video history was successfully destroyed"
  end
end
