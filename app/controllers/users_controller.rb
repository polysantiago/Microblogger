class UsersController < ApplicationController
  before_filter :authenticate,    :only => [:index, :edit, :update, :destroy]
  before_filter :illegal_access,  :only => [:new, :create]
  before_filter :correct_user,    :only => [:edit, :update]
  before_filter :admin_user,      :only => :destroy

  def new
    @user = User.new
    @title = 'Sign up'
  end

  def index
    @title = 'All users'
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find params[:id]
    @title = @user.name
  end

  def create
    @user = User.new params[:user]
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Doomker!"
      redirect_to @user
    else
      @title = "Sign up"
      render :new
    end
  end

  def edit    
    @title = "Edit user"
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:error] = "You cannot delete your own user"
    else
      flash[:success] = "User destroyed"
      @user.destroy
    end
    redirect_to users_path
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def illegal_access
    redirect_to(root_path) if signed_in?
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
