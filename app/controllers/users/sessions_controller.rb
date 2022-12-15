class Users::SessionsController < Devise::SessionsController
  #ゲストログイン機能
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end