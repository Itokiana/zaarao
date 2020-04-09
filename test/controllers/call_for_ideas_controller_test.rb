require 'test_helper'

class CallForIdeasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @call_for_idea = call_for_ideas(:one)
  end

  test "should get index" do
    get call_for_ideas_url
    assert_response :success
  end

  test "should get new" do
    get new_call_for_idea_url
    assert_response :success
  end

  test "should create call_for_idea" do
    assert_difference('CallForIdea.count') do
      post call_for_ideas_url, params: { call_for_idea: { name: @call_for_idea.name, project_id: @call_for_idea.project_id, type_id: @call_for_idea.type_id } }
    end

    assert_redirected_to call_for_idea_url(CallForIdea.last)
  end

  test "should show call_for_idea" do
    get call_for_idea_url(@call_for_idea)
    assert_response :success
  end

  test "should get edit" do
    get edit_call_for_idea_url(@call_for_idea)
    assert_response :success
  end

  test "should update call_for_idea" do
    patch call_for_idea_url(@call_for_idea), params: { call_for_idea: { name: @call_for_idea.name, project_id: @call_for_idea.project_id, type_id: @call_for_idea.type_id } }
    assert_redirected_to call_for_idea_url(@call_for_idea)
  end

  test "should destroy call_for_idea" do
    assert_difference('CallForIdea.count', -1) do
      delete call_for_idea_url(@call_for_idea)
    end

    assert_redirected_to call_for_ideas_url
  end
end
