require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters.push(('A'..'Z').to_a) }
    @letters.flatten!
    @choices = @letters.sample(10)
  end

  def check(word, choices, result)
    word.upcase.chars.each do |char|
      if choices.include?(char)
        word.delete_at(letters.index(char))
      else
        result[:message] = 'not in the grid'
        result[:score] = 0
      end
    end
    result
  end

  def api(word)
    url = 'https://wagon-dictionary.herokuapp.com/'
    url += word
    user_serialized = open(url).read
    api_return = JSON.parse(user_serialized)
    api_return
  end

  def score
    @word = params['word']
    @choices = params['choices']
    if @choices['hello']
      @word[:message] = 'well done'
      @word[:score] = user['length']
      @word[:score] += 1 if choices[:time] < 10.0
    else
      @word[:message] = 'That is not an English word'
      @word[:score] = 0
    end
    @word
  end
end
