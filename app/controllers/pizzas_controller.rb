class PizzasController < ApplicationController
  def index
    @thin_crust = Pizza.where(crust: "thick").get_top
    @thick_crust = Pizza.where(crust: "thick").get_top
    @deep_dish = Pizza.where(crust: "deep-dish").get_top
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
    @pizza = Pizza.find_by(id: params[:id])
    
    if @pizza.nil?
      head :not_found
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
end
