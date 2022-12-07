class Admin::InfoCommentsController < ApplicationController

  
  def destroy
    @comment = InfoComment.find(params[:id])
    @comment.destroy
    #BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    #redirect_to request.referer
  end

  def edit
    @info = Info.find(params[:info_id])
    @comment = InfoComment.find(params[:id])
  end

  def update
    @info = Info.find_by(params[:id])
    @comment = InfoComment.find(params[:id])
    if @comment.update(info_comment_params)
      redirect_to admin_info_path(@info.id)
    else
      render :edit
    end
  end

  private
  def info_comment_params
    params.require(:info_comment).permit(:comment)
  end
end
