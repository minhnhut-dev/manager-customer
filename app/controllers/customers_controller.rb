class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :show, only: [:show]

  layout "application"

  def index
    respond_to do |format|
      format.html { @customers = Customer.all }
    end
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  def import_customer
    return unless params[:file].present?
    file = params[:file]
    import_service = ImportServices.new(file)
    import_service.import_customers
    redirect_to customers_path, notice: 'Customers imported successfully!'
  end

  private

  def show
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone)
  end

end
