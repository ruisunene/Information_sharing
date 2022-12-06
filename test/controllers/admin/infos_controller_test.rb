require "test_helper"

class Admin::InfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_infos_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_infos_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_infos_edit_url
    assert_response :success
  end
end
