class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil? || letter.empty? || (!HangpersonGame.letter? letter)
    lower_letter = letter.downcase
    if @word.include? lower_letter
      if !@guesses.include? lower_letter
        @guesses << lower_letter
      else
        false
      end
    else
      if !@wrong_guesses.include? lower_letter
        @wrong_guesses << lower_letter
      else
        false
      end
    end
  end
  
  def word_with_guesses
    guessed_word = ""
    @word.split("").each do |letter|
      guessed_word << ((@guesses.include? letter) ? letter : "-")
    end
    return guessed_word
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if !word_with_guesses.include? "-"
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  private
  def self.letter?(letter)
    letter =~ /[A-Za-z]/
  end

end
