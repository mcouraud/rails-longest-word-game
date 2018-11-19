require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    url = 'https://wagon-dictionary.herokuapp.com/' + params[:word]
    word = open(url).read
    word_verification = JSON.parse(word)
    if word_verification['found'] == false
      @message = "Sorry but #{params[:word].upcase} doesn't seem to be a valid English word..."
    elsif word_verification['found'] == true && (params[:word].upcase.chars.all? { |letter| params[:word].upcase.count(letter) <= params[:letters].count(letter) }) == false
      @message = "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters]}"
    else
      @message = "Congratulations! #{params[:word].upcase} is a valid English word!"
    end
  end
end
