require "test_helper"

class ShiftPreferencesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get shift_preferences_new_url
    assert_response :success
  end
end
