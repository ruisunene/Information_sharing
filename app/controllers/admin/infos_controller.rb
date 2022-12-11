class Admin::InfosController < ApplicationController

  def index
    @info = Info.new
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @infos = @genre.infos.page(params[:page]).per(15)
    elsif @search_infos
      @infos = @search_infos.page(params[:page])
    else
      @info = Info.find_by(params[:page])
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
