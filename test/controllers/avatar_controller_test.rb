require 'test_helper'

class AvatarControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get avatar_new_url
    assert_response :success
  end

  test "should get create" do
    get avatar_create_url
    assert_response :success
  end

  test "should get destroy" do
    get avatar_destroy_url
    assert_response :success
  end

end
