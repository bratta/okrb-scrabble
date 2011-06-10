require "rubygems"
require "json"

class Scrabble
  attr_accessor :config, :tiles_on_hand
  
  def initialize  
    @config = JSON.parse(File.read("input.json")) 
    @tiles_on_hand = randomly_generate_tiles   
  end
      
  def get_word_from_tiles
    valid_words = {}
    letters = []
    scores = []
    @tiles_on_hand.each do |tile|
      tile.match(/^(\w)(\d+)$/) do |m|
        letters << m[1]
        scores << m[2]
      end
    end
    letters.permutation.to_a.each do |permutation|
      word = permutation.join("")
      valid_words[word] = score(word) if @config["dictionary"].include?(word)
    end
    valid_words.sort_by {|k,v| v}.last[0]
  end
  
  private  
  
  def score(word)
    score = 0
    word.split(//).each do |letter|
      @config["tiles"].each do |tile|
        tile.match(/^#{letter}(\d+)$/) do |m|
          score += m[1].to_i
        end
      end
    end
    score
  end
  
  def randomly_generate_tiles
    tiles = []
    9.times do
      tiles << @config["tiles"][rand(@config["tiles"].count)]
    end
    tiles
  end
end