require "test_helper"

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @shift = shifts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Shift.count' do
      post shifts_path, params: { shift: { otsutome_title: "kitchen" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Shift.count' do
      delete shift_path(@shift)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong shift" do
    log_in_as(users(:michael))
    shift = shifts(:ants)
    assert_no_difference 'Shift.count' do
      delete shift_path(shift)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end


end
