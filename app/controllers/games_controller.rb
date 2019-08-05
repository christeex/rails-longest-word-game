require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letter_array = ('a'..'z').to_a
    @letters = letter_array.sample(10)
  end

  def score
    if included?(params["word"], params["letters"].split('')) && valid?(params["word"])
      @result = "Congrats! #{params["word"]} is a valid word!"
    elsif included?(params["word"], params["letters"].split('')) && !valid?(params["word"])
      @result = "sorry but #{params["word"]} is not a valid English word"
    else
      @result = "sorry but #{params["word"]} can't be built from #{params["letters"]}"
    end
  end

  def create
  end

  def included?(word, letter_array)
    num = 0
    word.chars.each do |char|
      num += 1 if letter_array.include?(char)
    end
    num == word.size
  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    file = open(url).read
    api_result = JSON.parse(file)
    api_result["found"]
  end

  # def set_letters
  # end
end
