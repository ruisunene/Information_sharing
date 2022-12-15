class Public::InfoCommentsController < ApplicationController
#コメント機能
  def create
    @info = Info.find(params[:info_id])
    @comment = current_user.info_comments.new(info_comment_params)
    @comment.info_id = @info.id
    @comment.save
  end

  def destroy
    @comment = InfoComment.find(params[:id])
    @comment.destroy
  end

  def edit
    @info = Info.find(params[:info_id])
    @comment = InfoComment.find(params[:id])
  end

  def update
    @info = Info.find_by(params[:id])
    @comment = InfoComment.find(params[:id])
    if @comment.update(info_comment_params)
      redirect_to info_path(params[:info_id])
    else
      render :edit
    end
  end

  private
  def info_comment_params
    params.require(:info_comment).permit(:comment)
  end
end
