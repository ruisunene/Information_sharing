class Admin::InfosController < ApplicationController
  before_action :authenticate_admin!
#投稿の管理
  def index
    @info = Info.new
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @infos = @genre.infos.page(params[:page]).per(15)
    elsif @search_infos
      @infos = @search_infos.page(params[:page]).per(15)
    else
      @info = Info.find_by(params[:id])#find_byで複数の投稿を取得
      @infos = Info.page(params[:page]).per(15)
    end
  end

  def show
    @info = Info.find(params[:id])
    @info_new = Info.new
    @info_comment = InfoComment.new
    @genres = Genre.all
  end

  def edit
    @info = Info.find(params[:id])
  end

  def update
    @info = Info.find(params[:id])
    if @info.update(info_params)
      redirect_to admin_info_path(@info.id), notice: "更新できました"
    else
      render :edit
    end
  end

  def destroy
    @info = Info.find(params[:id])
    @info.destroy
    redirect_to admin_infos_path
  end

  def info_params
      params.require(:info).permit(:title, :body, :genre_id)
  end
end
