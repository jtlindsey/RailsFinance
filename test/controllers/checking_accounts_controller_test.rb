require 'test_helper'

class CheckingAccountsControllerTest < ActionController::TestCase
  setup do
    @checking_account = checking_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checking_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checking_account" do
    assert_difference('CheckingAccount.count') do
      post :create, checking_account: { balance: @checking_account.balance, last4: @checking_account.last4, name: @checking_account.name, status: @checking_account.status }
    end

    assert_redirected_to checking_account_path(assigns(:checking_account))
  end

  test "should show checking_account" do
    get :show, id: @checking_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checking_account
    assert_response :success
  end

  test "should update checking_account" do
    patch :update, id: @checking_account, checking_account: { balance: @checking_account.balance, last4: @checking_account.last4, name: @checking_account.name, status: @checking_account.status }
    assert_redirected_to checking_account_path(assigns(:checking_account))
  end

  test "should destroy checking_account" do
    assert_difference('CheckingAccount.count', -1) do
      delete :destroy, id: @checking_account
    end

    assert_redirected_to checking_accounts_path
  end
end
