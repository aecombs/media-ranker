class PizzasController < ApplicationController
  before_action :require_login, only: [:new, :edit, :destroy]
  before_action :get_pizza, except: [:index, :new, :create]

  def index
    @thin_crust = Pizza.where(crust: "thick").get_top
    @thick_crust = Pizza.where(crust: "thick").get_top
    @deep_dish = Pizza.where(crust: "deep-dish").get_top
  end

  def show
    if @pizza.nil?
      flash[:error] = "Unvalid Pizza ID"
      redirect_to pizzas_path
      return
    end
  end

  def new
    @pizza = Pizza.new
  end

  def create
    @pizza = Pizza.new(pizza_params)

    if @pizza.save
      flash[:success] = "Successfully designed pizza number #{@pizza.id}!"
      redirect_to pizza_path(@pizza.id)
      return
    else
      flash.now[:error] = "Unable to save pizza"
      render :new
      return
    end
  end

  def edit
    if @pizza.nil?
      flash[:error] = "Unvalid Pizza ID"
      redirect_to pizzas_path
      return
    end
  end

  def update
    if @pizza.nil?
      flash[:error] = "Unvalid Pizza ID"
      redirect_to pizzas_path
      return
    elsif @pizza.update(pizza_params)
      flash[:success] = "Successfully updated pizza number #{@pizza.id}"
      redirect_to pizza_path(@pizza.id)
      return
    else
      flash[:error] = "Unable to update pizza"
      render :edit
      return
    end
  end

  def destroy
    if @pizza.nil?
      flash[:error] = "Unvalid Pizza ID"
      redirect_to root_path
      return
    else
      name = @pizza.name
      @pizza.votes.each do |vote|
        vote.destroy
      end
      if @pizza.destroy
        flash[:success] = "Successfully removed #{name}"
        redirect_to pizzas_path
        return
      else
        flash.now[:error] = "Unable to delete #{name}"
        render :show
        return
      end
    end
  end

  private

  def pizza_params
    return params.require(:pizza).permit(:crust, :name, :sauce, :cheese, :toppings)
  end

  def get_pizza
    return @pizza = Pizza.find_by(id: params[:id])
  end
end
