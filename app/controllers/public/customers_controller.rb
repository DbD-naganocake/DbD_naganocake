class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  # before_action :authenticate_customer!	コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する

  def show
    @customer = current_customer
    # @customer = current_customer 現在ログインしている会員を取得する
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated　customer_info successfully."
    else
      render "edit"
    end
  end

  def quit
    @customer = current_customer
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    # 「reset_session」は全てのsessionを削除します
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last, :kana_first, :email, :post_code, :address, :telephone)
  end

end