require 'test/test_helper'

class TrollifierTest < Test::Unit::TestCase
  def test_create_image_with_three_components
    params = { :data =>
      [
        {:x => 10, :y => 100, :width => 200, :image => 1}
        # {:x => 220, :y => 10, :width => 300, :image => 2, :text => "I'm a php programmer :("},
        # {:x => 350, :y => 400, :text => "Sad but true"}
      ]
    }
    
    id = Trollifier.challenge_accepted(params)
    
    assert File.exists?(File.join(IMAGE_DIR,"#{id}.png")), 'File created'
  end
end