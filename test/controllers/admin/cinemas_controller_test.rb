require "test_helper"

class Admin::CinemasControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_cinemas_show_url
    assert_response :success
  end
end
