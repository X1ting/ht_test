class Api::V1::DataController < ApplicationController
  skip_before_action :authenticate_user!

  def parser
    link = DataParser::Parser.new(url_params).parsing
    return render json: {link: link}
  end


  private 

  def url_params
    params[:url]
  end
end