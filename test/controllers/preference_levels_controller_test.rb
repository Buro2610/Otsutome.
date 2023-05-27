require "test_helper"

class PreferenceLevelsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get preference_levels_edit_url
    assert_response :success
  end
end
