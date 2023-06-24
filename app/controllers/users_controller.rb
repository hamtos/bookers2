class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books.all
  end

  def index
    @user = current_user
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to edit_user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Profile update successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
