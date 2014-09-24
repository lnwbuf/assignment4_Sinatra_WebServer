require 'sinatra'
require 'geokit'
require 'timezone'

Timezone::Configure.begin do |c|
  c.username = 'revarite'
end

get '/' do
  erb :index
end

 
get '/gettime' do
  @city_name = params["cityname"]
  res = Geokit::Geocoders::GoogleGeocoder.geocode(@city_name)
  timezone = Timezone::Zone.new :latlon => res.ll.split(',')
  @current_time = timezone.time Time.now
  @current_time = @current_time.strftime "%I:%M %p"
  erb :gettime
end