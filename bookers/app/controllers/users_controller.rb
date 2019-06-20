class UsersController < ApplicationController

	before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
	  @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
  	@user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def index
  	@users = User.all
  	@book = Book.new
    @user = current_user
  end

  def update
  	@user = User.find(params[:id])
  	@user_id = current_user.id
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render("users/edit")
  	end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
