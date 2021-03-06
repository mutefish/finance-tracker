class UsersController < ApplicationController
  def my_portfolio
      @tracked_stocks = current_user.stocks
      @user = current_user
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      @friends.reject { |friend| current_user.is_friends_with(friend) }
      if @friends.any?
          respond_to do |format|
              format.js { render partial: 'users/friend_result' }
          end
      else 
          respond_to do |format|
              flash.now[:alert] = "Cannot find user!"
              format.js { render partial: 'users/friend_result' }
          end
      end
    else 
        respond_to do |format|
            flash.now[:alert] = "Please enter a user to search"
            format.js { render partial: 'users/friend_result' }
        end
    end
  end

  def show 
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
end
