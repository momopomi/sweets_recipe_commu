class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def index
    @recipes = Recipe.where(customer_id: current_customer.id)
    
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
        flash[:notice] = "edit successfully"
        redirect_to customer_path(@customer.id)
    else
        render :edit
    end
  end
  
  def check
    
  end
  
  def withdraw
    @customer = current_customer
    @customer.is_deleted = true
    if @customer.save
      reset_session
      redirect_to root_path
    end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :withdrawal_status)
  end
end
  


