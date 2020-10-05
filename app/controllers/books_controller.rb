class BooksController < ApplicationController

  before_action :login_check, only: [:index, :edit, :show]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save(book_params)
       redirect_to book_path(@book.id) ,notice: "creatad book successfully."
    else
    @user = User.find(current_user.id)
    @books = Book.all
    @users = User.all
    render :index
    end
  end

  def index
    @book = Book.new
    @user = User.find(current_user.id)
    @books = Book.all
    @users = User.all
  end

  def show
    @book = Book.new
    @user = User.find(current_user.id)
    @bookone = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book) ,notice: "successfully updated."
    else
    render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    @user = User.find(params[:id])
    redirect_to user_path(@user.id)
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def login_check
  unless user_signed_in?
    redirect_to new_user_session_path
  end
  end

end