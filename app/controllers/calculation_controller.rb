class CalculationController < ApplicationController

  def calculate
#     raise params.inspect
    render :update do |page|
      (0..8).each do |row|
	(0..8).each do |column|
	  page.insert_html :bottom, 'squares', "<input id='square_#{row}_#{column}' type='text' value='' size='1' name='square[#{row}_#{column}]'>"
	      #text_field_tag "squares[#{row}_#{column}]", '',:size => 1) 	
	end
	page.insert_html :bottom, 'squares', '<br>'
      end
    end
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
