require "application_system_test_case"

class CallForIdeasTest < ApplicationSystemTestCase
  setup do
    @call_for_idea = call_for_ideas(:one)
  end

  test "visiting the index" do
    visit call_for_ideas_url
    assert_selector "h1", text: "Call For Ideas"
  end

  test "creating a Call for idea" do
    visit call_for_ideas_url
    click_on "New Call For Idea"

    fill_in "Name", with: @call_for_idea.name
    fill_in "Project", with: @call_for_idea.project_id
    fill_in "Type", with: @call_for_idea.type_id
    click_on "Create Call for idea"

    assert_text "Call for idea was successfully created"
    click_on "Back"
  end

  test "updating a Call for idea" do
    visit call_for_ideas_url
    click_on "Edit", match: :first

    fill_in "Name", with: @call_for_idea.name
    fill_in "Project", with: @call_for_idea.project_id
    fill_in "Type", with: @call_for_idea.type_id
    click_on "Update Call for idea"

    assert_text "Call for idea was successfully updated"
    click_on "Back"
  end

  test "destroying a Call for idea" do
    visit call_for_ideas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Call for idea was successfully destroyed"
  end
end
