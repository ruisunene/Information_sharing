class Public::InfoCommentsController < ApplicationController

  def create
    @info = Info.find(params[:info_id])
    @comment = current_user.info_comments.new(info_comment_params)
    @comment.info_id = @info.id
    @comment.save
   # redirect_to request.referer
  end

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
      redirect_to info_path(params[:info_id])#@commit.idを追加してみたが変わらない
    else
      render :edit
    end
  end

  private
  def info_comment_params
    params.require(:info_comment).permit(:comment)
  end
end
