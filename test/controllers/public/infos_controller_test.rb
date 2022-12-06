require "test_helper"

class Public::InfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_infos_index_url
    assert_response :success
  end

  test "should get show" do
    get public_infos_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_infos_edit_url
    assert_response :success
  end
end
