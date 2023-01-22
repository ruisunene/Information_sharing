class Public::HomesController < ApplicationController
  before_action :authenticate_user!
  #トップページ
  def top
    @info = Info.find_by(params[:id])#複数のinfo_idを取得
    #本日の投稿のみ取得し、15件の情報が溜まったらページネーションする
    @infos = Info.where("created_at >= ?", Date.today).page(params[:page]).per(15).order(created_at: :desc)
    @genres = Genre.all
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @tags = Tag.all
  end

end
