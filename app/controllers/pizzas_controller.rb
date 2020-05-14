class PizzasController < ApplicationController
  def index
    @thin_crust = Pizza.where(crust: "thick")
    @thick_crust = Pizza.where(crust: "thick")
    @deep_dish = Pizza.where(crust: "deep-dish")
  end

  def show
    @pizza = Pizza.find_by(id: params[:id])
    if @pizza.nil?
      head :not_found
      return
    end
  end

  def new
    @pizza = Pizza.new
  end

  def create
    @pizza = Pizza.new(pizza_params)

    if @pizza.save
      redirect_to pizza_path(@pizza.id)
      return
    else
      render :new
      return
    end
  end

  def edit
    @pizza = Pizza.find_by(id: params[:id])

    if @pizza.nil?
      head :not_found
      return
    end
  end

  def update
    @pizza = Pizza.find_by(id: params[:id])

    if @pizza.nil?
      head :not_found
      return
    elsif @pizza.update(pizza_params)
      redirect_to pizza_path(@pizza.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @pizza = Pizza.find_by(id: params[:id])
    
    if @pizza.nil?
      head :not_found
      return
    else
      @pizza.votes.each do |vote|
        vote.destroy
      end
      @pizza.destroy
      redirect_to pizzas_path
      return
    end
  end


  private

  def pizza_params
    return params.require(:pizza).permit(:crust, :name, :sauce, :cheese, :toppings)
  end
end
