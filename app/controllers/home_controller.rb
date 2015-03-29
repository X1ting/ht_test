class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
  end
  
  def parser
    binding.pry
    redirect_to 'home#index'
  end

  private 

  def url_params
    params[:home][:url]
  end
end
