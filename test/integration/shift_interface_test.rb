require "test_helper"

class MicropostsInterface < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class MicropostsInterfaceTest < MicropostsInterface

  test "should paginate shifts" do
    get root_path
    assert_select 'div.pagination'
  end

  test "should show errors but not create shift on invalid submission" do
    assert_no_difference 'Shift.count' do
      post shifts_path, params: { shift: { start_time: "", end_time: "", otsutome_title: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # 正しいページネーションリンク
  end

  # test "should create a shift on valid submission" do
  #   content = "This shift really ties the room together"
  #   assert_difference 'Shift.count', 1 do
  #     post shifts_path, params: { shift: { otsutome_title: content } }
  #   end
  #   assert_redirected_to root_url
  #   follow_redirect!
  #   assert_match otsutome_title, response.body
  # end

  test "should have shift delete links on own profile page" do
    get users_path(@user)
    assert_select 'a', text: 'delete'
  end

  test "should be able to delete own shift" do
    first_shift = @user.shifts.paginate(page: 1).first
    assert_difference 'Shift.count', -1 do
      delete shift_path(first_shift)
    end
  end

  test "should not have delete links on other user's profile page" do
    get user_path(users(:archer))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end
