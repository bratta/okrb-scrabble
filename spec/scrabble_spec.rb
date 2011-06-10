require 'spec_helper.rb'

describe "Scrabble" do
  before do
    @scrabble = Scrabble.new
    @output = <<EOF
1 1 1 1 1 1 1 1 1 1 1 1
1 1 1 2 1 2 1 1 1 1 1 1
1 2 w h i f f l i n g 1
2 1 1 1 1 1 1 1 1 2 2 1
1 1 1 2 1 1 1 1 1 1 1 1
1 1 1 1 1 1 2 1 1 1 2 1
1 1 1 1 1 1 1 1 2 1 1 1
1 1 1 1 1 1 1 1 1 1 1 2
1 1 1 1 1 1 1 1 1 1 1 1
EOF
    @scrabble.tiles_on_hand = [ "w5", "h8", "i4", "f7", "f7", "l3", "i4", "n1", "g6" ]
  end
  
  it "loads the input data" do
    @scrabble.config.should_not be_empty
  end
  
  it "generates random tiles" do
    @scrabble.tiles_on_hand.count.should == 9
  end
  
  it "gets highest scoring word from the tiles on hand" do
    @scrabble.get_word_from_tiles.should == "whiffling"
  end
  
  it "shows the board with the most optimal first move" do
    #@scrabble.tiles_on_hand = [ "w5", "h8", "i4", "f7", "f7", "l3", "i4", "n1", "g6" ]
    #@scrabble.output_first_move.should == @output
  end
end