class RelationshipsController < ApplicationController
    before_action :logged_in_user

    def create
        @user = User.find(params[:followed_id])
        if(current_user.following?(@user))
            @error = 'Already followed user';
            respond_to do |format|
                format.html { redirect_to @user }
                format.js
            end
        else
            current_user.follow(@user)
            respond_to do |format|
              format.html { redirect_to @user }
              format.js
            end
        end
    end
    
    def destroy
        @user = Relationship.find(params[:id]).followed
        current_user.unfollow(@user) if current_user.following?(@user)
        
        respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
    end
end
