class CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customers_path, notice: 'Cliente cadastrado com sucesso!'
    else
      render :new
    end
  end

  def show
    @customer = Customer.find_by_id(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :email, :phone, :avatar, :smoker)
  end
end
