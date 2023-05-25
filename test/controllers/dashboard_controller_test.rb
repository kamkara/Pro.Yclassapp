require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_index_url
    assert_response :success
  end

  test "should get export" do
    get dashboard_export_url
    assert_response :success
  end

  test "should get course" do
    get dashboard_course_url
    assert_response :success
  end

  test "should get student" do
    get dashboard_student_url
    assert_response :success
  end

  test "should get ambassador" do
    get dashboard_ambassador_url
    assert_response :success
  end

  test "should get teacher" do
    get dashboard_teacher_url
    assert_response :success
  end

  test "should get home" do
    get dashboard_home_url
    assert_response :success
  end
end
