require "application_system_test_case"

class ViewersTest < ApplicationSystemTestCase
  setup do
    @viewer = viewers(:one)
  end

  test "visiting the index" do
    visit viewers_url
    assert_selector "h1", text: "Viewers"
  end

  test "creating a Viewer" do
    visit viewers_url
    click_on "New Viewer"

    fill_in "Actuality", with: @viewer.actuality_id
    fill_in "Idea", with: @viewer.idea_id
    fill_in "Project", with: @viewer.project_id
    fill_in "Survey", with: @viewer.survey_id
    fill_in "User", with: @viewer.user_id
    click_on "Create Viewer"

    assert_text "Viewer was successfully created"
    click_on "Back"
  end

  test "updating a Viewer" do
    visit viewers_url
    click_on "Edit", match: :first

    fill_in "Actuality", with: @viewer.actuality_id
    fill_in "Idea", with: @viewer.idea_id
    fill_in "Project", with: @viewer.project_id
    fill_in "Survey", with: @viewer.survey_id
    fill_in "User", with: @viewer.user_id
    click_on "Update Viewer"

    assert_text "Viewer was successfully updated"
    click_on "Back"
  end

  test "destroying a Viewer" do
    visit viewers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Viewer was successfully destroyed"
  end
end
