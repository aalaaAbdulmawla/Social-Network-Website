require 'test_helper'

class FriendablesControllerTest < ActionController::TestCase
  setup do
    @friendable = friendables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friendables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friendable" do
    assert_difference('Friendable.count') do
      post :create, friendable: { accepted: @friendable.accepted, from_id: @friendable.from_id, to_id: @friendable.to_id }
    end

    assert_redirected_to friendable_path(assigns(:friendable))
  end

  test "should show friendable" do
    get :show, id: @friendable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @friendable
    assert_response :success
  end

  test "should update friendable" do
    patch :update, id: @friendable, friendable: { accepted: @friendable.accepted, from_id: @friendable.from_id, to_id: @friendable.to_id }
    assert_redirected_to friendable_path(assigns(:friendable))
  end

  test "should destroy friendable" do
    assert_difference('Friendable.count', -1) do
      delete :destroy, id: @friendable
    end

    assert_redirected_to friendables_path
  end
end
