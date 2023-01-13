class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  #ログインユーザーの情報のみ編集可能
  before_action :ensure_correct_user, only: [:edit, :update]
#ユーザー機能
  def index
    @info = Info.new
    @genres = Genre.all
    @users = User.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @infos = @user.infos.page(params[:page]).per(5)#自分の投稿を表示。5件でページが変わる
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @genres = Genre.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新できました"
    else
      render "edit"
    end
  end

   private

  def user_params
    params.require(:user).permit(:name, :job, :phone_number, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end


end
