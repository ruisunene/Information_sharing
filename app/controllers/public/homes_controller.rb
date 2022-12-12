class Public::HomesController < ApplicationController
  before_action :authenticate_user!
  def top
    @info = Info.find_by(params[:id])#複数のinfo_idを取得
    #本日の投稿のみ取得し、15件の情報が溜まったらページネーションする
    @infos = Info.where("created_at >= ?", Date.today).page(params[:page]).per(15)
    @genres = Genre.all
    @info_new = Info.new
  end

end
