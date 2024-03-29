class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.all
    @users = User.page(params[:page]).per(15)
    @genres = Genre.all
  end

  def show
    @tags = Tag.all
    @user = User.find(params[:id])
    @infos = @user.infos.page(params[:page]).per(15)
    @genres = Genre.all
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "更新できました"
    else
      render "edit"
    end
  end

   private

  def user_params
    params.require(:user).permit(:name, :job, :phone_number, :is_deleted)
  end
end
