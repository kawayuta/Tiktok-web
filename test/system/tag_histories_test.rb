require "application_system_test_case"

class TagHistoriesTest < ApplicationSystemTestCase
  setup do
    @tag_history = tag_histories(:one)
  end

  test "visiting the index" do
    visit tag_histories_url
    assert_selector "h1", text: "Tag Histories"
  end

  test "creating a Tag history" do
    visit tag_histories_url
    click_on "New Tag History"

    fill_in "User nick named", with: @tag_history.user_nick_named
    fill_in "User official", with: @tag_history.user_official_id
    click_on "Create Tag history"

    assert_text "Tag history was successfully created"
    click_on "Back"
  end

  test "updating a Tag history" do
    visit tag_histories_url
    click_on "Edit", match: :first

    fill_in "User nick named", with: @tag_history.user_nick_named
    fill_in "User official", with: @tag_history.user_official_id
    click_on "Update Tag history"

    assert_text "Tag history was successfully updated"
    click_on "Back"
  end

  test "destroying a Tag history" do
    visit tag_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tag history was successfully destroyed"
  end
end
