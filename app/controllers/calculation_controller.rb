class CalculationController < ApplicationController

  def calculate
    table = setup_table
    CalculationController.validate(table)
    render :nothing => true
  end  

  private

  def self.validate(table)
    
#     raise table[4][0].inspect
#     render :update do |page|
    (0..8).each do |row|
      (0..8).each do |column|
	if table[row][column].count == 1
	  (0..8).each do |nbr|
	    if column != nbr and table[row][nbr].count == 1 and table[row][nbr][0] == table[row][column][0]
# 		page.alert "Same nbr in the same row!"
	      raise "Same nbr in the same row! #{row} #{nbr} and #{row} #{column}".inspect
	    end
	    if row != nbr and table[nbr][column].count == 1 and table[nbr][column][0] == table[row][column][0]
# 		page.alert "Same nbr in the same column!"
	      raise "Same nbr in the same column! #{nbr} #{column} and #{row} #{column}".inspect		
	    end
	  end
	  row_in_sqr = row - (row % 3) 
	  col_in_sqr = column - (column % 3)
	  (0..2).each do |row_nbr|
	    (0..2).each do |col_nbr|
	      if row != row_in_sqr+row_nbr and column != col_in_sqr+col_nbr and table[row_in_sqr+row_nbr][col_in_sqr + col_nbr] == table[row][column]
		raise "Same nbr in the same inner square! #{row} #{column} and #{row_in_sqr+row_nbr} #{col_in_sqr + col_nbr}".inspect		
	      end
	    end
	  end
	end
      end
    end
  end
  
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
	 row, column = key.split('_')
	 table[row.to_i][column.to_i] = [squares[key].to_i] 
	 puts ">>>>>>>>table[#{row}][#{column}] = #{table[row.to_i][column.to_i]}"
      end
    end
#     FOR DEBUGGING
#     table[0][1] = table[0][1] - [1,2,3,4,5,6,7,8]
#     raise table.inspect

#     raise table.inspect
    return table
    
    
  end

end
