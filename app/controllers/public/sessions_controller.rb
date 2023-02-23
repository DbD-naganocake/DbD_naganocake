# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_is_deleted, only: [:create]
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # def after_sign_in_path_for(resource)
    # admin_admin_path
  # end

  # def after_sign_out_path_for(resource)
    # new_admin_session_path
  # end
  def customer_is_deleted
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    #if @customer.valid_password?(params[:customer][:password]) && !@customer.status
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
      redirect_to new_customer_registration_path
      ## 【処理内容3】falseではなくtrueだった場合にサインアップページにリダイレクトする
    end
  end


end
