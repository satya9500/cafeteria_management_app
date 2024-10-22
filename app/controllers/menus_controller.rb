class MenusController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :ensure_user_logged_in
  before_action :ensure_owner

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

  def update
    id = params[:id]
    menu = Menu.find(id)
    menu.is_active = params[:is_active]
    menu.save!
    redirect_to menus_path
  end

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    menu.destroy!
    redirect_to menus_path
  end

  def create
    menu = Menu.new(
      name: params[:menu_name],
      is_active: params[:is_active],
    )
    if !menu.save
      flash[:error] = menu.errors.full_messages.join(", ")
    end
    redirect_to menus_path
  end
end
