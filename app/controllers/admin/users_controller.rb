class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

   private

  def user_params
    params.require(:user).permit(:name, :job, :phone_number)
  end
end
