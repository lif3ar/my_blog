class UsersController < ApplicationController
  
  def index
    @user = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to My Blog, #{@user.username}!"
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Information has been updated"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.destroy(params[:id])
    flash[:success] = "User has been deleted"
    redirect_to users_path
  end
  
  private
    def user_params
      params.require(:user).permit(:username, :email)
    end
end
