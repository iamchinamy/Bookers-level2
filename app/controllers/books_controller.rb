class BooksController < ApplicationController

	def new
	end

	def create
		@book = Book.new(book_params)
		@books = Book.all
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id)
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
		@books = Book.all
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end

end
