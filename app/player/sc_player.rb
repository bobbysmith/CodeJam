require 'soundcloud'

class Player
  def self.sc_player
    # create a client object with your app credentials
    client = Soundcloud.new(:client_id => 'YOUR_CLIENT_ID')

    # get a tracks oembed data
    track_url = 'http://soundcloud.com/forss/flickermood'
    embed_info = client.get('/oembed', :url => track_url)

    # print the html for the player widget
    puts embed_info['html']
  end
end
