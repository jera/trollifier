require 'test/test_helper'

class MainTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def browser
    @browser ||= Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
  end
  
  def test_create
    Trollifier.expects(:challenge_accepted).once.returns('1v7XB')
    
    browser.post "/create",
      { :data =>
        [
          {:x => 10, :y => 100, :width => 200, :image => 1},
          {:x => 220, :y => 10, :width => 300, :image => 2, :text => "I'm a php programmer :("},
          {:x => 350, :y => 400, :text => "Sad but true"}
        ]
      }
      
    

    assert browser.last_response.ok?, 'HTTP 200 expected'
    assert_equal '1v7XB', browser.last_response.body
  end
end