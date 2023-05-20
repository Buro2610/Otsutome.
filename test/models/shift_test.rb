require "test_helper"

class ShiftTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @shift = @user.shifts.build(start_time: "2023-05-09 02:51:49", end_time: "2023-05-09 03:51:49", otsutome_title: "kitchen")
  end

  test "should be valid" do
    assert @shift.valid?
  end

  test "user id should be present" do
    @shift.user_id = nil
    assert_not @shift.valid?
  end

  test "start_time should be present" do
    @shift.start_time = nil
    assert_not @shift.valid?
  end

  test "end_time should be present" do
    @shift.end_time = nil
    assert_not @shift.valid?
  end


  # test "otsutome_title should be present" do
  #   @shift.otsutome_title = "   "
  #   assert_not @shift.valid?
  # end

  test "otsutome_title should be at most 9 characters" do
    @shift.otsutome_title = "a" * 9
    assert_not @shift.valid?
  end

  test "order should be most recent first" do
    assert_equal shifts(:most_recent), Shift.first
  end

  test "start_time should before at end_time" do
    @shift.end_time = @shift.start_time-2.hours
    assert_not @shift.valid?
  end

end

