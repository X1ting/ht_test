class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
  end
  
  def parser
    binding.pry
     link = EmailParser::Parser.new(url_params).parser
    redirect_to 'home#index'
  end

  private 

  def url_params
    params[:home][:url]
  end
end
