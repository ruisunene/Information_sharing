class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
#ジャンル検索・一覧機能
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "保存しました"
    else
      @genres = Genre.all
      render "index"
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path, notice: "削除しました"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
