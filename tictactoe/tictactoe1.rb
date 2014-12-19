


# Game Display - displays changes to the user 
class Game

 @@userturn =nil 
 attr_accessor :username, :usermove, :array_map, :usersym, :computersym, :index,:possiblemoves, :user_position, :comp_position, :counter
 	
 	#initializes the game 
    def initialize(name,move,usersym)

      	#Base variable from initial user input
      	@username = name
       	@usermove = move
       	@usersym = usersym


       	
       	@user_position =[]	
       	@comp_position =[]
       	#list of possible moves made
       	@possiblemoves= [1,2,3,4,5,6,7,8,9]
       	#reference array to the output 
   	   	@array_map = [["","",""],["","",""],["","",""]]
   	   	#hash for mapping the mark on the output display 
   	   	@index = {1 => "[0][0]", 2 => "[0][1]",3 => "[0][2]",4 => "[1][0]",5 => "[1][1]",6 => "[1][2]",7 => "[2][0]",8 => "[2][1]",9 => "[2][2]"}
   	   	#winning combinations to be checked 
   	   	@winners = {1 => [1,2,3], 2 => [3,6,9], 3 => [4,5,6], 4 => [7,8,9], 5=> [3,5,7], 6=> [1,4,7], 7=> [2,5,8], 8=> [1,5,9]}
   	   	
   	   	self.symbolidentifier

   	   	loop do 
   	   

   	   	self.controller("user")
  	
 		self.output
  		
  		 this_person_win?("user")
   	   if @counter == 3 
   	   	
   	   	puts "Do you want to play again (Y/N)?"
   	   	@cmd = gets.chomp
   	   	if @cmd == "y"
   	   		
   	   		puts " what is your move?"
   	   		@usermove = gets.chomp
   	   		newgame = Game.new(@name,@usermove,@usersym)  
   	   	else 
   	   		break


   	   	end
   	   end

   	   	 this_person_win?("comp")
   	  	 break if @counter == 3 

   	   	 break if possiblemoves.length == 0
   	    
   	   	 	
   	   	

  		whos_turn? 
  	  
  		
  		end

    end

  

#Gather input from user for the "Identifier"
    def symbolidentifier

    	
		if @usersym.upcase == "X" then 
		   @compsym = "O" 
 		  else 
 		   @compsym = "X"
 		end 


    end

    def indexer(position)

    	@index[position]

    end

# GAME DISPLAY - reponsible for game output 
 
 	#Maps the User's and the computer's move 
 	def array_mapper(position,symbol) 
       text = indexer(position)
     	eval( "@array_map" + "#{text}" + "=" + "symbol")
   
 	end	

 	
 	#Outputs the initial display or changes made to it
	def output
	puts "  #{@array_map[0][0]} | #{@array_map[0][1]} |  #{@array_map[0][2]}  " 
	puts "------------"
	puts "  #{@array_map[1][0]} | #{@array_map[1][1]} |  #{@array_map[1][2]}  "
	puts "------------"
	puts "  #{@array_map[2][0]} | #{@array_map[2][1]} |  #{@array_map[2][2]}  "
	end
#==============================================================================================================

#GAME MODERDATOR - monitors game logic 
	
	def this_person_win?(who)
		@counter= 0

		@winners.each do |key,value|

		   break if @counter == 3 

			value.each do |x| 
		 	 um = eval("@"+who +"_position.include?(x)")
		 		if 	um == true then

		 	     @counter +=1 
			
		 		
		 	     puts "#{username} WINS" if @counter == 3 
		 	     
		 	   else
		 	 		@counter = 0
		 	   end
		    end
		end

	end


	def whos_turn?
		if @@userturn == true

			@usermove = gets.chomp 

			self.controller("user")
			#this_person_win?("user")
			
		else
			self.computermove_gen

			self.controller("comp")
			#this_person_win?("comp")
		end
	end
	


	# function checks if position is empty 
 	def check_move(position)
 		
 		eval("@array_map" + indexer(position) + ".empty?") 

 	end	
 	
 	def turnswitch(who)
 		if who == "user"
 			@@userturn=false
 		else
 			@@userturn=true
 		end
 	end


 	def controller(who)

 		@position = eval("@" + who +"move").to_i
 		@symbol =   eval("@" + who +"sym")
 		@possiblemoves -= [@position]
 		

 		if self.check_move(@position) == true then 

 			self.array_mapper(@position,@symbol) 
 			eval("@" + who + "_position") <<  @position

 			

 			turnswitch(who)
 			
 		  else 

 			self.position_not_empty
 		end
 

 	end

 

 	def position_not_empty 
 
 		puts "please enter a position that has not been occupied yet!"
 		
 	  
 	end	
#===============================================================================================================


#Computer class contains information about computer's move 

	def computermove_gen
		@comp_position

		@compmove = @possiblemoves.sample 
	

 	end



# User class contains information about the user's move

	
	#Gather input from user on the position to tick 
	
end




puts "Welcome to smarty pants Tic-Tac-toe"

puts "What is your name?"
	 name = gets.chomp

puts "Please select a symbol: X or O?"
      usersym = gets.chomp 
	 
puts "#{name},Please make your move!"
 	  usermove = gets.chomp 

newgame = Game.new(name,usermove,usersym)  
