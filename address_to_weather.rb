require 'open-uri'
require 'json'

# If you experience an error relating to SSL,
#   uncomment the following two lines:

# require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts "Let's get the weather forecast for your address."

puts "What is the address you would like to know the weather for?"
the_address = gets.chomp
url_safe_address = URI.encode(the_address)

url_of_data_we_want = "http://maps.googleapis.com/maps/api/geocode/json?address="
url = url_of_data_we_want + url_safe_address
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)
results = parsed_data["results"]
first = results[0]
geometry = first["geometry"]
location = geometry["location"]
lat = location["lat"]
lng = location["lng"]

the_latitude = lat
the_longitude = lng

url_of_data_want = "https://api.forecast.io/forecast/298307ef253aa87e5417597760d871fc/"
url_2 = url_of_data_want + the_latitude.to_s + "," + the_latitude.to_s
raw_data_2 = open(url_2).read
parsed_data_2 = JSON.parse(raw_data_2)
currently = parsed_data_2["currently"]
temperature = currently["temperature"]
the_temperature = temperature

hourly = parsed_data_2["hourly"]
data = hourly["data"]
first = data[1]
summary = first["summary"]
the_hour_outlook = summary

daily = parsed_data_2["daily"]
data = daily["data"]
first = data[1]
summary = first["summary"]
the_day_outlook = summary

# Ultimately, we want the following line to work when uncommented:

puts "The current temperature at #{the_address} is #{the_temperature} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook}"
puts "The outlook for the next day is: #{the_day_outlook}"
