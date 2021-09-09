#when game starts script loads dictionary
  #randomly selects word between 5 and 12 chars for secret word

#every turn player makes a guess
  #if out of guesses player loses

#display guesses player has left before game ends
  #iterative instance variable that decreases every time method run

#display correct (&incorrect)letters that have been chosen
  #two different arrays
  #when guesses_array.include?(secret_word_array) player wins


#class Player

#end

class Computer
	def get_random_word
		random_word_file = File.open("5desk.txt", "r")
		random_word_array = random_word_file.read.split("\r\n")
		random_word = random_word_array.sample
		until random_word.length > 4 && random_word.length < 13 do
			random_word = random_word_array.sample
		end
		p random_word
	end
end

new_computer = Computer.new
new_computer.get_random_word