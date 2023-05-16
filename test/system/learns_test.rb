require "application_system_test_case"

class LearnsTest < ApplicationSystemTestCase
  setup do
    @learn = learns(:one)
  end

  test "visiting the index" do
    visit learns_url
    assert_selector "h1", text: "Learns"
  end

  test "should create learn" do
    visit learns_url
    click_on "New learn"

    fill_in "Level name", with: @learn.level_name
    fill_in "Material name", with: @learn.material_name
    fill_in "Slug", with: @learn.slug
    fill_in "Title", with: @learn.title
    fill_in "User", with: @learn.user_id
    click_on "Create Learn"

    assert_text "Learn was successfully created"
    click_on "Back"
  end

  test "should update Learn" do
    visit learn_url(@learn)
    click_on "Edit this learn", match: :first

    fill_in "Level name", with: @learn.level_name
    fill_in "Material name", with: @learn.material_name
    fill_in "Slug", with: @learn.slug
    fill_in "Title", with: @learn.title
    fill_in "User", with: @learn.user_id
    click_on "Update Learn"

    assert_text "Learn was successfully updated"
    click_on "Back"
  end

  test "should destroy Learn" do
    visit learn_url(@learn)
    click_on "Destroy this learn", match: :first

    assert_text "Learn was successfully destroyed"
  end
end
