class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book_new = Book.new
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end
  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
    redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if@user.update(user_params)
    redirect_to user_path(@user.id), notice:'successfully'
    else
      render 'edit'
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
