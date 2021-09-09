def get_random_word
		random_word_file = File.open("5desk.txt", "r")
		random_word_array = random_word_file.read.split("\r\n")
		random_word = random_word_array.sample.downcase
		until random_word.length > 4 && random_word.length < 13 do
			random_word = random_word_array.sample.downcase
		end
		random_word
end

