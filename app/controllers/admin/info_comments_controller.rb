class Admin::InfoCommentsController < ApplicationController


  def destroy
    @comment = InfoComment.find(params[:id])
    @comment.destroy
  end

  def edit
    @info = Info.find(params[:info_id])
    @comment = InfoComment.find(params[:id])
  end

  def update
    @info = Info.find_by(params[:info_id])
    @comment = InfoComment.find(params[:id])
    if @comment.update(info_comment_params)
      redirect_to admin_info_path(params[:info_id])
      #(@info.id)
      #(params[:info_id])
    else
      render :edit
    end
  end

  private
  def info_comment_params
    params.require(:info_comment).permit(:comment)
  end
end
