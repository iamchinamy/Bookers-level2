class BooksController < ApplicationController
	before_action :authenticate_user!

	def new
	end

	def create
		@book = Book.new(book_params)
		@books = Book.all
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id)
			flash[:notice] = "You have creatad book successfully."
		else
			render :index
		end
	end

	def index
		@book = Book.new
		@books = Book.all
	end

	def show
		@book = Book.find(params[:id])
		@book_new = Book.new
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
		if not @book.user.id == current_user.id
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(@book.id)
			flash[:notice] = "You have updated book successfully."
		else
			render action: :edit
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
