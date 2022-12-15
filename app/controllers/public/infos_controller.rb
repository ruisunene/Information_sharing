class Public::InfosController < ApplicationController
  before_action :authenticate_user!
  #ログインユーザーのみ投稿の編集と削除ができる
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

#投稿機能
  def create
    @info = Info.new(info_params)
    @info.user_id = current_user.id
    if @info.save
      redirect_to info_path(@info), notice: "投稿に成功しました"
    else
      #遷移後投稿一覧で必要な記述
      @info_new = Info.new #この記述がないとrender後の投稿機能が動作しない
      @infos = Info.page(params[:page]).per(15)#投稿が15件でページが変わる
      @genres = Genre.all#ジャンル一覧を表示
      render 'index'

    end
  end

  def index
    @info_new = Info.new
    @genres = Genre.all
    #ジャンルの検索結果を抽出
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @info = Info.find_by(params[:page])
      @infos = @genre.infos.page(params[:page]).per(15)
    elsif @search_infos
      @info = Info.find_by(params[:page])
      @infos = @search_infos.page(params[:page]).per(15)
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

