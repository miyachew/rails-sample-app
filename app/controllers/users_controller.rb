class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy
    before_action :not_yourself,   only: :destroy

    def index
      @users = User.paginate(page: params[:page].presence)
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          reset_session
          log_in @user
          flash[:success] = "Welcome to the Sample App!"
          redirect_to @user
        else
          render 'new'
        end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    end

    def destroy
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end

    private
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

      # Confirms a logged-in user.
      def logged_in_user
          store_location
          unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
      end

      # Confirms a logged-in user.
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end

      # Confirms an admin user.
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end

      # Confirms user is not current user
      def not_yourself
        @user = User.find(params[:id])
        redirect_to(root_url) unless !current_user?(@user)
      end
    end 
end
