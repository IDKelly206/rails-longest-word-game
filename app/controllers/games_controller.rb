require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(a e i o u)

  def new
    @letters = Array.new(4) {VOWELS.sample}
    @letters += Array.new(6) { (('a'..'z').to_a - VOWELS).sample }
    @letters.shuffle!
    # raise
  end

  def score
    @letters = params[:letters].upcase.split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end



  private
  def included?(word, letters)
    # word.chars.all?{|letter| word.count(letter) <= letters.count(letter)}
    chars = word.chars
    matching = chars.map { |c| letters.include?(c) }
    match = matching.include?(false)
    !match
  end


  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json["found"]
  end


end
# @a_chars = @word.chars
# @a_chars.map do |char|
#     if @letters.include?(char)
#       puts "True"
#     else
#       puts "False"
#     end
#  end
