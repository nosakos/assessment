class NumeralsController < ApplicationController

	def index
		render :index
	end

	def numerals
		render plain: ((is_number?(params[:number])) ? to_string(params[:number]) : "Please enter the number in the text box!")
	end

	private
		def is_number? string
  			true if Integer(string) rescue false
  		end

  		def to_string number
  			""
  		end
end
