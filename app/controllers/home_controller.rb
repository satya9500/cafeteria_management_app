class HomeController < ApplicationController
  def index
    if current_user
      redirect_to "/main"
    else
      render "index"
    end
  end
end
