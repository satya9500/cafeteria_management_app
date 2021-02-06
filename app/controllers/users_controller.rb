class UsersController < ApplicationController
  before_action :ensure_user_not_logged_in, only: [:create, :new, :createOwner, :createOwnerPage]
  before_action :ensure_user_logged_in, only: [:index, :createClerkPage, :createClerk]
  before_action :ensure_owner, only: [:destroy, :createClerk, :index, :createClerkPage]

  def new
    render "users/new"
  end

  def index
    user_type = params[:user_type]
    if user_type != nil
      @users = User.find_by(role: user_type)
    else
      @users = User.all
    end
    render "users/all"
  end

  # Create online customer
  def create
    user = User.new(
      email: params[:email],
      name: params[:name],
      role: "customer",
      password: params[:password],
    )
    if user.save
      session[:current_user_id] = user.id
      session[:current_user_role] = user.role
      session[:cart] = Array.new
      redirect_to "/"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def createClerkPage
    render "users/new_clerk"
  end

  def createClerk
    user = User.new(
      email: params[:email],
      name: params[:name],
      role: "clerk",
      password: params[:password],
    )
    if user.save
      redirect_to "/users"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to register_clerk_page
    end
  end

  def createOwnerPage
    render "users/new_owner"
  end

  def createOwner
    if params[:secret] != "thereisnosuchsecret"
      flash[:error] = "Secret is incorrent..Hmmm ! That's Suspicious !"
      redirect_to register_owner_page_path and return
    end
    user = User.new(
      email: params[:email],
      name: params[:name],
      role: "owner",
      password: params[:password],
    )
    if user.save
      session[:current_user_id] = user.id
      session[:current_user_role] = user.role
      session[:cart] = Array.new
      redirect_to "/"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to register_owner_page
    end
  end
end
