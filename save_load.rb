
def save_game(player_instance)
	puts "Would you like to save the game, type 'Yes' if you would."
	player_response = gets.chomp
	if player_response == 'Yes'
		File.open('saved_game', 'w+') do |file|
				Marshal.dump(player_instance, file)
		end
	end
end

def load_game(player_instance)
	puts "Would you like to load the game, type 'Yes' if you would."
	player_response = gets.chomp
	if player_response == 'Yes'
		File.open('saved_game') do |file|
			player_instance = Marshal.load(file)
		end
	end
end