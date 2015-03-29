class Api::V1::DataController < ApplicationController
  skip_before_action :authenticate_user!

	def parser
    binding.pry
    link = DataParser::Parser.new(url_params).parsing
	end


	private 

  def url_params
    params[:url]
  end
end