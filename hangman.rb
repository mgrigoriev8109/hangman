require_relative 'random_word.rb'
require_relative 'save_load.rb'

class Player

	def initialize(random_word)
		@random_word = random_word.split('')
		@correct_guesses = Array.new(@random_word.length, '_')
		@incorrect_guesses = Array.new
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
		p @random_word
		p "What letter would you like to guess for the random word?"
		@player_guess = gets.chomp.downcase
		if @random_word.include?(@player_guess)
			p "You have guessed the letter #{@player_guess} correctly!"
			display_correct_guesses
			check_game_victory
			p @correct_guesses
		else
			@guesses_left -= 1
			@incorrect_guesses.push(@player_guess)
			p "You have guessed #{@player_guess} incorrectly, you have #{@guesses_left} guesses left"
			p @correct_guesses
		end
	end

	def play_game
		until @guesses_left == 0 do
			marshal_load
      player_turn
			marshal_dump
		end
		p "You have lost the game!"
	end

	def check_game_victory
		if @correct_guesses == @random_word
			p "You have won the game!"
			exit
		end
	end

	def marshal_dump
		puts "Would you like to save the game, type 1 to save."
		player_response = gets.chomp
		if player_response == '1'
			File.open('saved_game', 'w+') do |file|
				Marshal.dump([@random_word, @correct_guesses, @incorrect_guesses, @guesses_left, @player_guess ], file)
			end
		end
	end

	def marshal_load
		puts "Would you like to load the game, type 2 to load."
		player_response = gets.chomp
		if player_response == '2'
			@random_word, @correct_guesses, @incorrect_guesses, @guesses_left, @player_guess  = Marshal.load(File.binread('saved_game'))
		end
	end
end

new_player = Player.new(get_random_word)
new_player.play_game