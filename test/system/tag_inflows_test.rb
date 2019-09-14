require "application_system_test_case"

class TagInflowsTest < ApplicationSystemTestCase
  setup do
    @tag_inflow = tag_inflows(:one)
  end

  test "visiting the index" do
    visit tag_inflows_url
    assert_selector "h1", text: "Tag Inflows"
  end

  test "creating a Tag inflow" do
    visit tag_inflows_url
    click_on "New Tag Inflow"

    fill_in "Tag", with: @tag_inflow.tag
    fill_in "Youtube", with: @tag_inflow.youtube
    click_on "Create Tag inflow"

    assert_text "Tag inflow was successfully created"
    click_on "Back"
  end

  test "updating a Tag inflow" do
    visit tag_inflows_url
    click_on "Edit", match: :first

    fill_in "Tag", with: @tag_inflow.tag
    fill_in "Youtube", with: @tag_inflow.youtube
    click_on "Update Tag inflow"

    assert_text "Tag inflow was successfully updated"
    click_on "Back"
  end

  test "destroying a Tag inflow" do
    visit tag_inflows_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tag inflow was successfully destroyed"
  end
end
