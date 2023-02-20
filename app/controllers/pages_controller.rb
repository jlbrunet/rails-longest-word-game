require "open-uri"
require "json"

class PagesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters.push(('A'..'Z').to_a.sample)
    end

    session[:scoring] = 0 unless session[:scoring].present?
  end

  def score
    @word = params[:sugg].upcase
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    read = URI.open(url).read
    @parse = JSON.parse(read)
    if @parse['found']
      session[:scoring] += @word.length
      @output = "Congratulations! #{@word} is a valid English word!"
    else
      @output = "Sorry but #{@word} can't be built out of #{@letters.split(' ')[0]}, #{@letters.split(' ')[1]}, #{@letters.split(' ')[2]}, #{@letters.split(' ')[3]}, #{@letters.split(' ')[4]}, #{@letters.split(' ')[5]}, #{@letters.split(' ')[6]}, #{@letters.split(' ')[7]}, #{@letters.split(' ')[8]}, #{@letters.split(' ')[9]}"
    end
  end
end
