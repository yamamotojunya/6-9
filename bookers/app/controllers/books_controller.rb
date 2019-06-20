class BooksController < ApplicationController

	before_action :authenticate_user!

	def new
		@book = Book.new
	end

	def create
	    @book = Book.new(book_params)
	    @book.user_id = current_user.id
	    if @book.save
	    	redirect_to book_path(@book), notice: "You have creatad book successfully."
	    else
	    	@books = Book.all
			@user = User.find_by(params[:id])
	    	render("books/index")
	    end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@book_form = Book.new
		@user = User.find_by(id: @book.user_id)
	end

	def destroy
	    @book = Book.find(params[:id])
	    @book.destroy
	    redirect_to books_path
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user.id != current_user.id
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			redirect_to book_path(@book.id), notice: "You have creatad book successfully."
		else
			
			render("books/edit")
		end
	end

	private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
