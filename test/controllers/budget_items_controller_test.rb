require 'test_helper'

class BudgetItemsControllerTest < ActionController::TestCase
  setup do
    @budget_item = budget_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:budget_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create budget_item" do
    assert_difference('BudgetItem.count') do
      post :create, budget_item: { amount: @budget_item.amount, category: @budget_item.category, due_date: @budget_item.due_date, period: @budget_item.period }
    end

    assert_redirected_to budget_item_path(assigns(:budget_item))
  end

  test "should show budget_item" do
    get :show, id: @budget_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @budget_item
    assert_response :success
  end

  test "should update budget_item" do
    patch :update, id: @budget_item, budget_item: { amount: @budget_item.amount, category: @budget_item.category, due_date: @budget_item.due_date, period: @budget_item.period }
    assert_redirected_to budget_item_path(assigns(:budget_item))
  end

  test "should destroy budget_item" do
    assert_difference('BudgetItem.count', -1) do
      delete :destroy, id: @budget_item
    end

    assert_redirected_to budget_items_path
  end
end
