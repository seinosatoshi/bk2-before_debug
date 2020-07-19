class UsersController < ApplicationController
    before_action :authenticate_user!
  # before_action :ensure_correct_user, only: [:update]

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice]="You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # def ensure_correct_user
  #   @user = User.find(params[:id])
  #   unless @user == current_user
  #     redirect_to user_path(current_user)
  #   end
  # end
end
