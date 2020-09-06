class FriendshipsController < ApplicationController
    
    def create
        Friendship.create(user_id: params[user_id], friend_id: params[friend_id])
        redirect_to my_friends_path
    end

    def destroy
        friendship = current_user.friendships.where(friend_id: params[:id]).first
        friendship.destroy 
        flash[:notice] = "Unfriend"
        redirect_to my_friends_path
    end

end