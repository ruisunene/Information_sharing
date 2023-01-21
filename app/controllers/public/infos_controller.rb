#ユーザー側の情報の投稿に関するコントローラー
class Public::InfosController < ApplicationController
  before_action :authenticate_user!
  #ログインユーザーのみ投稿の編集と削除ができる
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @info = Info.new
  end

  def create
    @info = Info.new(info_params)
    @info.user_id = current_user.id #投稿とユーザーを紐付け
    if @info.save
      @info.save_tags(params[:info][:tag])
      redirect_to info_path(@info), notice: "投稿に成功しました"
    else
      render 'new'
    end
  end

  def index
    @genres = Genre.all
    @bookmarks = Bookmark.where(user_id: current_user.id)#ブックマークの表示をログインしているユーザーに紐付け
    #ジャンルの検索結果を抽出
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @info = Info.find_by(params[:info_id])
      @infos = @genre.infos.page(params[:page]).per(15).order(created_at: :desc)#1ページの表示を15個までし、新しい投稿が上に表示される
    #サーチでの検索結果を摘出
    elsif @search_infos
      @info = Info.find_by(params[:info_id])
      @infos = @search_infos.page(params[:page]).per(15).order(created_at: :desc)
    else
      #通常の投稿を抽出
      @info = Info.find_by(params[:info_id])
      @infos = Info.page(params[:page]).per(15).order(created_at: :desc)
    end
  end

  def show
    @info = Info.find(params[:id])
    @user = @info.user
    @info_comment = InfoComment.new
    @memo = Memo.new
    @genres = Genre.all
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def edit
    @info = Info.find(params[:id])
  end

  def update
    @info = Info.find(params[:id])
    if @info.update(info_params)
      @info.save_tags(params[:info][:tag])
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
# 投稿に紐づいているユーザーと現在ログインしているユーザーか確認
    def ensure_correct_user
      @info = Info.find(params[:id])
      unless @info.user == current_user
        redirect_to infos_path
      end
    end

end

