class FriendshipsController < ApplicationController
    
    def create
        current_user.friends << User.find(params[:friend])
        if current_user.save
            flash[:notice] = "Following user"
        else  
            flash[:alert] = "An error occured"
        end
        redirect_to my_friends_path
    end

    def destroy
        friendship = current_user.friendships.where(friend_id: params[:id]).first
        friendship.destroy 
        flash[:notice] = "Unfriend"
        redirect_to my_friends_path
    end

end