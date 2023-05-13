require "application_system_test_case"

class StatutsTest < ApplicationSystemTestCase
  setup do
    @statut = statuts(:one)
  end

  test "visiting the index" do
    visit statuts_url
    assert_selector "h1", text: "Statuts"
  end

  test "should create statut" do
    visit statuts_url
    click_on "New statut"

    fill_in "Slug", with: @statut.slug
    fill_in "Title", with: @statut.title
    fill_in "User", with: @statut.user_id
    click_on "Create Statut"

    assert_text "Statut was successfully created"
    click_on "Back"
  end

  test "should update Statut" do
    visit statut_url(@statut)
    click_on "Edit this statut", match: :first

    fill_in "Slug", with: @statut.slug
    fill_in "Title", with: @statut.title
    fill_in "User", with: @statut.user_id
    click_on "Update Statut"

    assert_text "Statut was successfully updated"
    click_on "Back"
  end

  test "should destroy Statut" do
    visit statut_url(@statut)
    click_on "Destroy this statut", match: :first

    assert_text "Statut was successfully destroyed"
  end
end
