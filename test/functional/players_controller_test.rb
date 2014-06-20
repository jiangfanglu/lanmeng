require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, player: { alias: @player.alias, number: @player.number, total_assist: @player.total_assist, total_block: @player.total_block, total_dunk: @player.total_dunk, total_rebound: @player.total_rebound, total_score: @player.total_score, total_steal: @player.total_steal, user_id: @player.user_id }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player
    assert_response :success
  end

  test "should update player" do
    put :update, id: @player, player: { alias: @player.alias, number: @player.number, total_assist: @player.total_assist, total_block: @player.total_block, total_dunk: @player.total_dunk, total_rebound: @player.total_rebound, total_score: @player.total_score, total_steal: @player.total_steal, user_id: @player.user_id }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_redirected_to players_path
  end
end
