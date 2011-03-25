require 'test/test_helper'

class TrollifierTest < Test::Unit::TestCase
  def test_dont_have_image
    assert !Trollifier.have_image?(nil), 'Dont have image'
  end
  
  def test_have_image
    assert Trollifier.have_image?({:image => 1}), 'Have image'
  end
  
  def test_join_two_images
    image_blank         = Magick::Image.read(File.join(TEST_IMAGES,"blank.png")).first
    image_small_square  = Magick::Image.read(File.join(TEST_IMAGES,"small_square.png")).first
    Trollifier.join_images(image_blank,image_small_square)
    
    image_path = write_in_tmp(image_blank)
    
    assert File.exists?(image_path), 'File with union exists'
    
    rollback_image(image_path)
  end
  
  
  
  
  
  def test_create_image_with_one_image_component
    params = { :data => [ {:x => 10, :y => 100, :width => 200, :image => 1} ] }
    
    id = Trollifier.challenge_accepted(params)
    image_path = File.join(IMAGE_DIR,"#{id}.#{IMAGE_EXTENSION}")
    
    assert File.exists?(image_path), 'File created'
    rollback_image(image_path)
  end
  
  
  def test_create_image_with_one_image_and_text_component
    params = {:data => 
      [{:x => 220, :y => 10, :width => 300, :image => 2, :text => "I'm a php programmer :("}]
    }
    
    id = Trollifier.challenge_accepted(params)
    image_path = File.join(IMAGE_DIR,"#{id}.#{IMAGE_EXTENSION}")
    
    assert File.exists?(image_path), 'File created'
    rollback_image(image_path)
  end
  
  
  
  private
  
  def write_in_tmp(image)
    path = File.join(TEST_IMAGES,"fake_image_to_delete.png")
    image.write(path)
    path
  end
  
  def rollback_image(image_path)
    File.unlink(image_path)
  end
end