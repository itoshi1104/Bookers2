class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
   @user = User.find(current_user.id)
   @book_new = Book.new
   @books = Book.all
  end

  def show
    @user = User.find(current_user.id)
    @book_new =  Book.new
    @books = Book.all
    @book = Book.find(params[:id])
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if@book_new.save
    redirect_to book_path(@book_new), notice:'successfully'
    else
    @user = User.find(current_user.id)
    @books = Book.all
    render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
    redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if@book.update(book_params)
    redirect_to book_path(@book.id), notice:'successfully'
    else
    render  'edit'
    end
  end

  def destroy
   @book = Book.find(params[:id])
   @book.destroy
   redirect_to books_path
  end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
