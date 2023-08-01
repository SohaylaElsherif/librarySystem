require "test_helper"

class PendingBorrowRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pending_borrow_requests_index_url
    assert_response :success
  end

  test "should get create" do
    get pending_borrow_requests_create_url
    assert_response :success
  end

  test "should get update" do
    get pending_borrow_requests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pending_borrow_requests_destroy_url
    assert_response :success
  end
end
