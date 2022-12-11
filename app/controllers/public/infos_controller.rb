class Public::InfosController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @info = Info.new(info_params)
    @info.user_id = current_user.id
    if @info.save
      redirect_to info_path(@info), notice: "投稿に成功しました"
    else
      @info_new = Info.new #この記述がないとrender後の投稿機能が動作しない
      #@info_new = Info.find_by(params[:page])
      #@info = Info.find_by(params[:page])
      @infos = Info.page(params[:page]).per(15)
      @genres = Genre.all
      render 'index'
      #redirect_to request.referer
    end
  end

  def index
    @info_new = Info.new
    @genres = Genre.all
    #ジャンルの検索結果を抽S出
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @info = Info.find_by(params[:page])
      @infos = @genre.infos.page(params[:page]).per(15)
    elsif @search_infos
      @info = Info.find_by(params[:page])
      @infos = @search_infos.page(params[:page])
    else
      #情報一覧を抽出
      @info = Info.find_by(params[:page])
      @infos = Info.page(params[:page]).per(15)
    end
  end

  def show
    @info = Info.find(params[:id])
    @info_new = Info.new
    @info_comment = InfoComment.new
    @memo = Memo.new
    @genres = Genre.all
  end

  def edit
    @info = Info.find(params[:id])
  end

  def update
    @info = Info.find(params[:id])
    if @info.update(info_params)
      redirect_to info_path(@info.id), notice: "更新できました"
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

