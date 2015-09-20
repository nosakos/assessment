class NumeralsController < ApplicationController

	@@small_numbers = Array["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
	@@tens = Array["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
	@@big_numbers = Array["", "thousand", "million", "billion"]

	def index
		render :index
	end

	def numerals
		render plain: ((is_number?(params[:number])) ? to_string(params[:number].to_i) : "Please enter the number in the text box!")
	end

	private
		def is_number? string
  			true if Integer(string) rescue false
  		end

  		def to_string number
  			if number == 0
  				return @@small_numbers[0]
  			end

  			digits = Array[0, 0, 0, 0]

            positive = number.abs

            i = 0
            while i < 4 do
                digits[i] = positive%1000
                positive /= 1000
                i += 1
            end

            group_string = Array["", "", "", ""]

            i = 0
            while i < 4 do
                group_string[i] = group_to_string(digits[i])
                i += 1
            end
            puts group_string

            combined = group_string[0];
            
            append_and = (digits[0] > 0) && (digits[0] < 100);

            i = 1
            while i < 4 do
            	if digits[i] != 0
                	prefix = group_string[i] + " " + @@big_numbers[i];

                    if combined.length != 0
                        prefix += append_and ? " and " : " ";
                    end

                    append_and = false;
                    combined = prefix + combined;
                end

                i += 1
            end

            return combined
  		end

  		def group_to_string group
  			group_string = ""

			hundreds = group/100;
            tens_units = group%100;

            if hundreds != 0
            	group_string += @@small_numbers[hundreds] + " hundred"

                if tens_units != 0
                    group_string += " and "
                end
            end

            tens = tens_units/10;
            units = tens_units%10;

            if tens >= 2
                group_string += @@tens[tens];
                if units != 0
                    group_string += " " + @@small_numbers[units];
                end
            elsif tens_units != 0
                group_string += @@small_numbers[tens_units];
            end

            return group_string;
  		end
end
