require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Otsutome."
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Otsutome."
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Otsutome."
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Otsutome."
  end

  test "should get calendar" do
    get calendar_path
    assert_response :success
    assert_select "title", "Calendar | Otsutome."
  end


end