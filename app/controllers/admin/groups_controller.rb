class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.page(params[:page]).per(20)
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
     @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_groups_path, notice: "更新できました"
    else
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to admin_groups_path, notice: "グループを退出しました"
  end

  def all_destroy
    @group = Group.find(params[:group_id])
    if @group.destroy
    redirect_to admin_groups_path, notice: "グループを削除しました"
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

end
