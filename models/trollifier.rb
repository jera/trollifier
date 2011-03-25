require 'RMagick'

class Trollifier
  def self.challenge_accepted(params)
    validate
    
    image       = Magick::Image.new(800,600)
    image_id    = generate_id(5)
    image_path  = File.join(IMAGE_DIR,"#{image_id}.#{IMAGE_EXTENSION}")
    
    params[:data].each do |data|
      puts "#{data.inspect}"
      if have_image?(data)
        join_images(image,read_image(data['image']),data)
      end
      
      
      if have_text?(data)
        write_in_image(image,data)
      end
      
      image = image.write(image_path)
      
      
    end
    
    image_id
  end
  
  private
  
  def self.join_images(image,image_over,data={})
    data = {
      'x' => 0,
      'y' => 0,
      'width' => image_over.columns
    }.merge(data)
    
    scale!(image_over,data)

    image.composite!(image_over, data['x'].to_i, data['y'].to_i, Magick::OverCompositeOp)
  end
  
  def self.write_in_image(image,data)
    text = Magick::Draw.new
    text.annotate(image, data['width'].to_i, 0, (data['x'].to_i+1), (data['y'].to_i+10), data['text']) {
      self.font_family  = 'Courier new'
      self.font_style   = Magick::NormalStyle
      self.font_weight  = 400
      self.pointsize    = 12
      self.stroke       = 'transparent'
    }
    
  end
  
  def self.have_image?(data)
    data && data.has_key?('image') && data['image'].to_s != ""
  end
  
  def self.have_text?(data)
    data && data.has_key?('text') && data['text'].to_s != ""
  end
  
  def self.scale!(image,data)
    image.resize!(scale(image,data))
    data['height'] = image.rows
  end
  
  def self.scale(image,data)
    (data['width'].to_f / image.columns)
  end
  
  def self.read_image(image)
    path_image = File.join(RAGE_COMIC_DIR,"#{image}.#{IMAGE_EXTENSION}")
    if File.exists?(path_image)
      Magick::Image.read(path_image).first
    end
  end
  
  # author http://snippets.dzone.com/posts/show/491
  def self.generate_id( len )
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      newpass
  end
  
  def self.validate
    unless File.exists?(IMAGE_DIR)
      raise "Create '#{IMAGE_DIR}' directory"
    end
    
    unless File.exists?(RAGE_COMIC_DIR)
      raise "Create '#{RAGE_COMIC_DIR}' directory"
    end
  end
end