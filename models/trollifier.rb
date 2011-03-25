require 'RMagick'

class Trollifier
  def self.challenge_accepted(params)
    image       = Magick::Image.new(800,600)
    image_id    = generate_id(5)
    image_path  = File.join(IMAGE_DIR,"#{image_id}.#{IMAGE_EXTENSION}")
    
    params[:data].each do |data|
      if have_image?(data)
        join_images(image,read_image(data[:image]),data).write(image_path)
        image = image.write(image_path)
      end
    end
    
    image_id
  end
  
  
  private
  
  def self.join_images(image,image_over,options_image_over={})
    options_image_over = {
      :x => 0,
      :y => 0,
      :width => image_over.columns
    }.merge(options_image_over)
    
    scale = options_image_over[:width].to_f / image_over.columns
    image_over.resize!(scale)
    
    image.composite!(image_over, options_image_over[:x], options_image_over[:y], Magick::OverCompositeOp)
  end
  
  # author http://snippets.dzone.com/posts/show/491
  def self.generate_id( len )
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      newpass
  end
  
  def self.read_image(image)
    path_image = File.join(RAGE_COMIC_DIR,"#{image}.#{IMAGE_EXTENSION}")
    if File.exists?(path_image)
      Magick::Image.read(path_image).first
    end
  end
  
  def self.have_image?(data)
    data && data.has_key?(:image) && data[:image].to_s != ""
  end
end