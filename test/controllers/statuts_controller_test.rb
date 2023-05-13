require "test_helper"

class StatutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @statut = statuts(:one)
  end

  test "should get index" do
    get statuts_url
    assert_response :success
  end

  test "should get new" do
    get new_statut_url
    assert_response :success
  end

  test "should create statut" do
    assert_difference("Statut.count") do
      post statuts_url, params: { statut: { slug: @statut.slug, title: @statut.title, user_id: @statut.user_id } }
    end

    assert_redirected_to statut_url(Statut.last)
  end

  test "should show statut" do
    get statut_url(@statut)
    assert_response :success
  end

  test "should get edit" do
    get edit_statut_url(@statut)
    assert_response :success
  end

  test "should update statut" do
    patch statut_url(@statut), params: { statut: { slug: @statut.slug, title: @statut.title, user_id: @statut.user_id } }
    assert_redirected_to statut_url(@statut)
  end

  test "should destroy statut" do
    assert_difference("Statut.count", -1) do
      delete statut_url(@statut)
    end

    assert_redirected_to statuts_url
  end
end
