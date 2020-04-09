require 'test_helper'

class ActualitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @actuality = actualities(:one)
  end

  test "should get index" do
    get actualities_url
    assert_response :success
  end

  test "should get new" do
    get new_actuality_url
    assert_response :success
  end

  test "should create actuality" do
    assert_difference('Actuality.count') do
      post actualities_url, params: { actuality: { admin_id: @actuality.admin_id, content: @actuality.content, name: @actuality.name } }
    end

    assert_redirected_to actuality_url(Actuality.last)
  end

  test "should show actuality" do
    get actuality_url(@actuality)
    assert_response :success
  end

  test "should get edit" do
    get edit_actuality_url(@actuality)
    assert_response :success
  end

  test "should update actuality" do
    patch actuality_url(@actuality), params: { actuality: { admin_id: @actuality.admin_id, content: @actuality.content, name: @actuality.name } }
    assert_redirected_to actuality_url(@actuality)
  end

  test "should destroy actuality" do
    assert_difference('Actuality.count', -1) do
      delete actuality_url(@actuality)
    end

    assert_redirected_to actualities_url
  end
end
