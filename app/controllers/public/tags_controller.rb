class Public::TagsController < ApplicationController
 before_action :authenticate_user!
  def show
    @tag = Tag.find(params[:id])
    @tags = Tag.all
    @genres = Genre.all
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def tag_params
    params.require(:tags).permit(:name)
  end
end
