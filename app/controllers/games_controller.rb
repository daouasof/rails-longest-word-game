require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10)
    @letters = @letters.map { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params['word'].downcase
    @letters = params['letters'].downcase.split
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    json = JSON.parse(URI.open(url).read)
    @english = json["found"]
    @composition = @word.chars.all? { |letter| @letters.include?(letter) && @word.count(letter) <= @letters.count(letter) }
  end
end
