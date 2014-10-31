class UsersController < ApplicationController
 before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
   before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
 
  def new
      @user = User.new
  end
  
   def index
    @users = User.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
   
  
  def show
    @user = User.find(params[:id])
     @microposts = @user.microposts.paginate(page: params[:page])
  end
    
   def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
      def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
        # Before filters
    end
    
    def signed_in_user
        unless signed_in?
        store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
    end
    
        def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
        def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_ur
    end
      def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
