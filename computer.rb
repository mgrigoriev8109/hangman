class Computer
	def initialize
			@player_response = ''
			@guesses_left = 6
	end
	
	def get_random_word
		random_word_file = File.open("5desk.txt", "r")
		random_word_array = random_word_file.read.split("\r\n")
		random_word = random_word_array.sample.downcase
		until random_word.length > 4 && random_word.length < 13 do
			random_word = random_word_array.sample.downcase
		end
		random_word
	end

	def play_game(player_turn, player_instance)
		until @guesses_left == 0 do
			save_game(player_instance)
            player_turn
            @guesses_left -= 1
		end
		p "You have lost the game!"
	end

	def save_game(player_instance)
		puts "Would you like to save the game, type 'Yes' if you would."
		@player_response = gets.chomp
		if @player_response == 'Yes'
			File.open('saved_game', 'w+') do |file|
				Marshal.dump(player_instance, file)
			end
		end
	end
end

