class Public::InfosController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @info = Info.new(info_params)
    @info.user_id = current_user.id
    if @info.save
      redirect_to info_path(@info), notice: "投稿に成功しました"
    else
      @infos = Info.all
      render 'index'
    end
  end

  def index
    @infos =Info.all
    @info = Info.new
  end

  def show
    @info = Info.find(params[:id])
    @info_new = Info.new
    @info_comment = InfoComment.new
  end

  def edit
    @info = Info.find(params[:id])
  end

  def update
    @info = Info.find(params[:id])
    if @info.update(info_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to info_path(@info.id)
    else
      render :edit
    end
  end

  def destroy
    @info = Info.find(params[:id])
    @info.destroy
    redirect_to "/infos"
  end

  private

    def info_params
      params.require(:info).permit(:title, :body, :genre_id)
    end

    def ensure_correct_user
      @info = Info.find(params[:id])
      unless @info.user == current_user
        redirect_to infos_path
      end
    end

end

