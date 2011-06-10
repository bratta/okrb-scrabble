require "rubygems"
require "json"
require "pp"

class Scrabble
  attr_accessor :config, :board, :tiles_on_hand
  
  def initialize  
    @config = JSON.parse(File.read("input.json")) 
    @board = build_board(@config["board"])
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
    valid_words.each_pair do |word, score|
      boards_for_word = position_word(word, score)
      pp boards_for_word.max
    end
  end
  
  private  
  
  def build_board(board_input)
    board_input.map { |row| row.split.map {|cell| cell.to_i } }
  end
  
  def score(word)
    score = []
    word.split(//).each do |letter|
      score << get_score_for_letter(letter)
    end
    score
  end
  
  def get_score_for_letter(letter)
    @config["tiles"].grep(/^#{letter}/).first[/\d+/].to_i
  end
  
  def position_word(word, score)
    boards = {}
    @board.each_with_index do |row, y|
      0.upto(@board[y].size - word.length) do |x|
        current_score = score.zip(@board[y][x,word.length]).inject(0) { |total, ns| total + ns[0].to_i * ns[1].to_i }
        final_board = @board.dup.map { |row| row.dup }
        final_board[y].replace(@board[y][0...x] + word.split(//) + @board[y][(x+word.length)..-1])
        boards[current_score] = final_board
      end
    end
    boards
  end
  
  def randomly_generate_tiles
    tiles = []
    9.times do
      tiles << @config["tiles"][rand(@config["tiles"].count)]
    end
    tiles
  end
end