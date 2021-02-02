class MenusController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_user_is_owner

  def new
    "/menus/new"
  end

  def index
    @menus = Menu.all
    render "/menus/index"
  end

  def show
    @menu = Menu.find_by_id(params[:id])
    @menu_items = MenuItem.where(menu_id: params[:id])
    render "/menus/show"
  end

  def create
    Menu.create(
      name: params[:menu_name],
      is_active: params[:is_active],
    )
    redirect_to menus_path
  end
end
