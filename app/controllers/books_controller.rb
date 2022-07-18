class BooksController < ApplicationController

  before_action :ensure_user, only: [:edit, :update, :destroy]


  def new
    @book = Book.new
  end

  def create
    @user =  current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render '/books/index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update

    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user =  current_user
  end

  def show
    @books = Book.find(params[:id])
    @book = Book.new
    @user = @books.user
  end

  def destroy
   flash[:notice] = " Book was successfully destroyed."
   book = Book.find(params[:id])
   book.destroy
   redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to '/books'
    end
  end

end
