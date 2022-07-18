class UsersController < ApplicationController

   before_action :ensure_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
    @user =  current_user

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    flash[:notice] = "successfully"
    redirect_to books_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
