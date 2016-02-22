class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @user = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to My Blog, #{@user.username}!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Information has been updated"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User has been deleted"
    redirect_to users_path
  end
  
  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can't perform that action"
        redirect_to root_path
      end
    end
    
    def require_admin
      if logged_in? and !current_user.admin?
        redirect_to root path
      end
    end
    
end
