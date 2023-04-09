class Users::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

# ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected
# BANされたアカウントを弾くメソッド
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if @user.valid_password?(params[:user][:password])&&@user.is_stopped
      redirect_to new_user_registration_path, notice: "アカウントが停止されています"
    end
  end
end