class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @group = Group.new
    @groups = Group.page(params[:page]).per(20)
  end

  def show
    @group = Group.find(params[:id])
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to groups_path
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path, notice: "グループを作成しました"
    else
      @group = Group.new
      @groups = Group.page(params[:page]).per(20)
      render 'index'
    end
  end

  def edit
     @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "更新できました"
    else
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path, notice: "グループを退出しました"
  end

  def all_destroy
    @group = Group.find(params[:group_id])
    if @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
