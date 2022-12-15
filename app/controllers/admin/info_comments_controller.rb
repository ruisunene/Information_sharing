class Admin::InfoCommentsController < ApplicationController
  before_action :authenticate_admin!
#管理者コメント編集機能
  def destroy
    @comment = InfoComment.find(params[:id])
    @comment.destroy
  end

  def edit
    @info = Info.find(params[:info_id])#情報idを持つレコードを取得
    @comment = InfoComment.find(params[:id])
  end

  def update
    @info = Info.find(params[:info_id])
    @comment = InfoComment.find(params[:id])
    if @comment.update(info_comment_params)
      redirect_to admin_info_path(params[:info_id])
    else
      render 'edit'
    end
  end

  private
  def info_comment_params
    params.require(:info_comment).permit(:comment)
  end
end
