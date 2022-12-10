class Public::HomesController < ApplicationController
  before_action :authenticate_user!
  def top
    #@info = Info.order('id ASC')
    @info = Info.find_by(params[:page])
    @infos = Info.page(params[:page]).per(5).order('id DESC')
    @genres = Genre.all
    @info_new = Info.new
  end

end
