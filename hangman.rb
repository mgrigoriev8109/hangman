require_relative 'random_word.rb'
require 'yaml'

class Player

  attr_reader :random_word, :correct_guesses, :incorrect_guesses, :guesses_left, :player_guess

  def initialize(random_word)
    @random_word = random_word.split('')
    @correct_guesses = Array.new(@random_word.length, '_')
    @incorrect_guesses = Array.new
    @guesses_left = 6
    @player_guess = ''
  end

  def player_turn
    puts "What letter would you like to guess for the random word?"
    @player_guess = gets.chomp.downcase
    if @random_word.include?(@player_guess)
      puts "You have guessed the letter #{@player_guess} correctly!"
      modify_correct_guesses
      check_game_victory
    else
      @guesses_left -= 1
      @incorrect_guesses.push(@player_guess)
      puts "You have guessed #{@player_guess} incorrectly, you have #{@guesses_left} guesses left."
    end
    puts "The correct letters you have guessed so far are #{@correct_guesses}"
    puts "The incorrect letters you have guessed so far are #{@incorrect_guesses.join('')}"
  end

  def play_game
    load_game
    until @guesses_left.zero?
      player_turn
      save_game
    end
    puts "You have lost the game!"
  end

  def modify_correct_guesses
    @random_word.each_with_index do |letter, index|
      if letter == @player_guess
        @correct_guesses[index] = @player_guess
      end
    end
  end

  def check_game_victory
    if @correct_guesses == @random_word
      puts "You have won the game!"
      exit
    end
  end

  def save_game
    puts "Would you like to save the game, type 'save' to save."
    player_response = gets.chomp
    return unless player_response == 'save'

    File.open('saved_game.yml', 'w+') do |file|
      YAML.dump([] << self, file)
    end
  end

  def load_game
    puts "Would you like to load the game, type 'load' to load."
    player_response = gets.chomp
    return unless player_response == 'load'

    yaml = YAML.load_file('saved_game.yml')
    @random_word = yaml[0].random_word
    @correct_guesses = yaml[0].correct_guesses
    @incorrect_guesses = yaml[0].incorrect_guesses
    @guesses_left = yaml[0].guesses_left
    @player_guess = yaml[0].player_guess
  end
end

new_player = Player.new(get_random_word)
new_player.play_game
