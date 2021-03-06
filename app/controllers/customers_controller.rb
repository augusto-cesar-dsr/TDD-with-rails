class CustomersController < ApplicationController

  before_action :set_customer, only: [:edit, :show, :update, :destroy]

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
  end

  def edit
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: 'Cliente apagado com sucesso!'
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: 'Cliente atualizado com sucesso!'
    else
        render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :email, :phone, :avatar, :smoker)
  end

  def set_customer
    @customer = Customer.find_by_id(params[:id])
  end
end
