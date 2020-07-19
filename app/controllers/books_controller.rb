class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to "/books"
    end
  end



  def update
    @book = Book.find(params[:id])
    @books = Book.all
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "index"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
