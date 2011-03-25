require 'RMagick'

class Trollifier
  def self.challenge_accepted(params)
    image = Magick::Image.new(800,600)
    
    
    params[:data].each do |data|
      component = Magick::Image.read(File.join(RAGE_COMIC_DIR,"#{data[:image]}.#{IMAGE_EXTENSION}")).first
      scale = data[:width].to_f / component.columns
      component.resize!(scale)
      image.composite!(component, data[:x],data[:y],Magick::OverCompositeOp)
    end
    
    id = generate_id(5)
    image.write(File.join(IMAGE_DIR,"#{id}.#{IMAGE_EXTENSION}"))
    id
  end
  
  
  private
  # author http://snippets.dzone.com/posts/show/491
  def self.generate_id( len )
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
  end
end