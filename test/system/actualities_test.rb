require "application_system_test_case"

class ActualitiesTest < ApplicationSystemTestCase
  setup do
    @actuality = actualities(:one)
  end

  test "visiting the index" do
    visit actualities_url
    assert_selector "h1", text: "Actualities"
  end

  test "creating a Actuality" do
    visit actualities_url
    click_on "New Actuality"

    fill_in "Admin", with: @actuality.admin_id
    fill_in "Content", with: @actuality.content
    fill_in "Name", with: @actuality.name
    click_on "Create Actuality"

    assert_text "Actuality was successfully created"
    click_on "Back"
  end

  test "updating a Actuality" do
    visit actualities_url
    click_on "Edit", match: :first

    fill_in "Admin", with: @actuality.admin_id
    fill_in "Content", with: @actuality.content
    fill_in "Name", with: @actuality.name
    click_on "Update Actuality"

    assert_text "Actuality was successfully updated"
    click_on "Back"
  end

  test "destroying a Actuality" do
    visit actualities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Actuality was successfully destroyed"
  end
end
