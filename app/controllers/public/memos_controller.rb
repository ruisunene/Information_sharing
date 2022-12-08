class Public::MemosController < ApplicationController

  def create
    @info = Info.find(params[:info_id])
    @memo = current_user.memos.new(memo_params)
    @memo.info_id = @info.id
    @memo.save
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
  end

  def edit
    @info = Info.find(params[:info_id])
    @memo = Memo.find(params[:id])
  end

  def update
    @info = Info.find_by(params[:id])
    @memo = Memo.find(params[:id])
    if @memo.update(memo_params)
      redirect_to info_path(params[:info_id])#indo_idでidを取得しないと元の詳細ページに戻らない
    else
      render :edit
    end
  end

  private
  def memo_params
    params.require(:memo).permit(:memo)
  end
end
