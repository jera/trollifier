begin
  require ::File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end
require 'sinatra'
require 'models/trollifier'


RAGE_COMIC_DIR  = 'rage_comic'
IMAGE_DIR       = 'images'
IMAGE_EXTENSION = 'png'


post '/create' do
  faces = []
  params[:data].each do |k,v|
    faces << v
  end
  
  Trollifier.challenge_accepted({ :data => faces })
end