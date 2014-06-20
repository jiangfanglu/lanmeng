require 'test_helper'

class WeblogsControllerTest < ActionController::TestCase
  setup do
    @weblog = weblogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weblogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weblog" do
    assert_difference('Weblog.count') do
      post :create, weblog: { blog_type: @weblog.blog_type, content: @weblog.content, title: @weblog.title, user_id: @weblog.user_id }
    end

    assert_redirected_to weblog_path(assigns(:weblog))
  end

  test "should show weblog" do
    get :show, id: @weblog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weblog
    assert_response :success
  end

  test "should update weblog" do
    put :update, id: @weblog, weblog: { blog_type: @weblog.blog_type, content: @weblog.content, title: @weblog.title, user_id: @weblog.user_id }
    assert_redirected_to weblog_path(assigns(:weblog))
  end

  test "should destroy weblog" do
    assert_difference('Weblog.count', -1) do
      delete :destroy, id: @weblog
    end

    assert_redirected_to weblogs_path
  end
end
