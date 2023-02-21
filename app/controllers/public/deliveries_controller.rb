class Public::DeliveriesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @delivery = Delivery.new
    @deliveries = current_customer.deliveries
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer = current_customer
    if @delivery.save
      redirect_to"/deliveries"
    else
      @deliveries = Delivery.all
      render :index
    end
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
    redirect_to deliveries_path(@delivery), notice: "you have update delivery_info successfully"
    else
      render "edit"
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to '/deliveries'
  end

  private

  def delivery_params
    params.require(:delivery).permit(:delivery_post, :delivery_address, :name)
  end

end
