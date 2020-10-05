class UsersController < ApplicationController

  before_action :login_check, only: [:index, :edit, :show]

  def index
    @book = Book.new
    @user = User.find(current_user.id)
    @users = User.all
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id) ,notice: "successfully updated."
    else
    render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def login_check
  unless user_signed_in?
    redirect_to new_user_session_path
  end
  end

end
