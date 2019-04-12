require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  # test "index as admin including pagination and delete links" do
  #   log_in_as(@admin)
  #   get users_path
  #   assert_template 'users/index'
  #   assert_select 'div.pagination'
  #   first_page_of_users = User.paginate(page: 1)
  #   assert_select 'img', count:30
  #   assert_select 'a.user-link'
  #   assert_select 'a',text: "← Previous"
  #   first_page_of_users.each do |user|
  #     # assert_select 'a',text: user.name
  #     # assert_select 'a.user-link', text: user.name
  #     assert_match "aaa", response.body
  #     assert_match "/users/", response.body
  #     # assert_select 'a[href=?]', user_path(user), text: user.name
  #     unless user == @admin
  #       assert_select 'a[href=?]', user_path(user), text: 'delete'
  #     end
  #   end
  #   assert_difference 'User.count', -1 do
  #     delete user_path(@non_admin)
  #   end
  # end
   test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    assert_select 'img', count:30
    # first_page_of_users = User.paginate(page: 1)
    # first_page_of_users.each do |user|
    users = User.all
    users do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end