require 'test_helper'

class GrowsControllerTest < ActionController::TestCase
  setup do
    @grow = grows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grow" do
    assert_difference('Grow.count') do
      post :create, grow: { name: @grow.name, start_date: @grow.start_date }
    end

    assert_redirected_to grow_path(assigns(:grow))
  end

  test "should show grow" do
    get :show, id: @grow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grow
    assert_response :success
  end

  test "should update grow" do
    patch :update, id: @grow, grow: { name: @grow.name, start_date: @grow.start_date }
    assert_redirected_to grow_path(assigns(:grow))
  end

  test "should destroy grow" do
    assert_difference('Grow.count', -1) do
      delete :destroy, id: @grow
    end

    assert_redirected_to grows_path
  end
end
