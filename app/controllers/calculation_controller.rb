class CalculationController < ApplicationController

  def calculate
    table = setup_table
  end  

  private

  # Setup the 3 dimensional matrix table
  def setup_table
    
    table = []
    (0..8).each do |row|
      table.push([])
      (0..8).each do |column|
	table[row].push([1,2,3,4,5,6,7,8,9])
      end
    end
    
    squares = params[:squares]
    squares.keys.each do |key|
      unless squares[key].eql?("")
	 row, column = key.split('')
	 table[row.to_i][column.to_i] = [squares[key].to_i] 
      end
    end
#     raise table.inspect
#     FOR DEBUGGING
#     table[0][1] = table[0][1] - [1,2,3,4,5,6,7,8]
#     raise table.inspect
    
    
  end
#   render :nothing => true
end
