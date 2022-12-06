class Public::InfoCommentsController < ApplicationController
  def create
    @info = Info.find(params[:info_id])
    @comment = current_user.info_comments.new(info_comment_params)
    @comment.info_id = info.id
    @comment.save
   # redirect_to request.referer
  end

  def destroy
    @comment = InfoComment.find(params[:id])
    @comment.destroy
    #BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    #redirect_to request.referer
  end

  private
  def info_comment_params
    params.require(:info_comment).permit(:comment)
  end
end
