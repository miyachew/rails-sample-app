require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select "div.alert", text: "The form contains 4 errors."
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'new name'
    email = 'new@email.com'
    patch user_path(@user), params: { user: { name:  name,
                                         email: email,
                                         password:              "",
                                         password_confirmation: "" } }
    assert_not_empty flash
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
