require "test_helper"

class GuestSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get guest_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get guest_sessions_create_url
    assert_response :success
  end
end
