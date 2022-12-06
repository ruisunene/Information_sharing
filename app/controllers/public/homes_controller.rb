class Public::HomesController < ApplicationController
  before_action :authenticate_user!
  def top
    @genres = Genre.all
  end

end
