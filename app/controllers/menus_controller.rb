class MenusController < ApplicationController

  before_action do
    @store = Store.find(params[:store_id])
  end

  def index
    @menus = @store.menus
  end

  def show
    @menu = @store.menus.find(params[:id])
  end

  def new
    @menu = @store.menus.new
  end

  def create
    @menu = @store.menus.new(menu_params)
    if @menu.save
      redirect_to store_menus_path, :notice => "New menu was created"
    else
      render "new"
    end
  end

  def edit
    @menu = @store.menus.find(params[:id])
  end

  def update
    @menu = @store.menus.find(params[:id])
    if @menu.update(menu_params)
      redirect_to store_menus_path, :notice => "menu information was updated"
    else
      render "edit"
    end
  end

  def destroy
    @menu = @store.menus.find(params[:id])
    @menu.destroy
    redirect_to store_menus_path, :notice => "menu was deleted"
  end

  private

  def menu_params
    params.require(:menu).permit(:name)
  end

end
