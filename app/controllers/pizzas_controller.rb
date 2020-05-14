class PizzasController < ApplicationController
  def index
    @thin_crust = Pizza.where(crust: "thick")
    @thick_crust = Pizza.where(crust: "thick")
    @deep_dish = Pizza.where(crust: "deep-dish")
  end

  def show
    @pizza = Pizza.find_by(id: params[:id])
  end

  def new
    @pizza = Pizza.new
  end

  def create

  end

  def edit
    @pizza = Pizza.find_by(id: params[:id])
  end

  def update
    @pizza = Pizza.find_by(id: params[:id])
  end

  def destroy
    @pizza = Pizza.find_by(id: params[:id])
  end
end
