class Admin::TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @tags = Tag.all
    @genres = Genre.all
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to admin_infos_path
  end

  def tag_params
    params.require(:tags).permit(:name)
  end
end


