#every turn player makes a guess
  #if out of guesses player loses

#display correct (&incorrect)letters that have been chosen
  #two different arrays
  #when guesses_array.include?(secret_word_array) player wins


class Player
	attr_reader :random_word

	def initialize(random_word)
		@random_word = random_word.split('')
		@correct_guesses = Array.new(@random_word.length, '-')
		@guesses_left = 6
		@player_guess = ''
	end

	def display_correct_guesses
		@random_word.each_with_index do |letter, index|
			if letter == @player_guess
				@correct_guesses[index] = @player_guess
			end
		end
	end

	def player_turn
		p "What letter would you like to guess for the random word?"
		@player_guess = gets.chomp
		if @random_word.include?(@player_guess)
			p "You have guessed correctly!"
			display_correct_guesses
			p @correct_guesses
		else
			@guesses_left -= 1
			p "You have guessed incorrectly and have #{@guesses_left} guesses left"
			p @correct_guesses
			#if out of guesses player loses
		end
	end
end

class Computer
	def get_random_word
		random_word_file = File.open("5desk.txt", "r")
		random_word_array = random_word_file.read.split("\r\n")
		random_word = random_word_array.sample
		until random_word.length > 4 && random_word.length < 13 do
			random_word = random_word_array.sample
		end
		random_word
	end
end

new_computer = Computer.new

new_player = Player.new (new_computer.get_random_word)
p new_player.random_word
new_player.player_turn