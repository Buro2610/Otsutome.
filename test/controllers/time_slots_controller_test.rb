require "test_helper"

class TimeSlotsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get time_slots_edit_url
    assert_response :success
  end
end
