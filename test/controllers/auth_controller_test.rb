require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get signup_url
    assert_response :success
    assert_select 'title', full_title('Sign up')
  end
end
