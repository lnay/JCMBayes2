require 'discordrb'
require "erb"
require "RMagick2"
require 'yaml'

auth = YAML.load_file("auth.yml")
bot_token = auth["token"]
channel_id = auth["channel"]

puts "The Bot Token is #{bot_token}"
puts "The channel ID is #{channel_id}"

bot = Discordrb::Bot.new token: bot_token

locations = ["JCMB", "Bayes"]
# hash associating each location to an empty list (to fill with attendees)
people = locations.map{ |loc| [loc.downcase, []] }.to_h

def shame(message)
  ['🇸', '🇭', '🇦', '🇲', '🇪', '👹'].each &message.method(:create_reaction)
  sleep 10
  message.delete
end

def gen_table_img(people, filename)
  svg_template = ERB.new File.read "./TableTemplate.svg.erb"
  img = Magick::Image.from_blob(svg_template.result binding) { format='SVG' }
  img[0].write filename
end

permissible_message = /^
  (?<location>#{locations.join("|")}) # start with one location
  (\s+[a-z0-9_\-:\.]+)? # Followed by optional extra, separated by a space
  [!?]? # End with optional punctuation
$/ix

bot.message() do |event|
  if event.content =~ permissible_message
    location = $~['location']
    name = event.author.display_name
    location_attendees = people[location.downcase]
    location_attendees << name unless location_attendees.include?(name)
    gen_table_img people, "out.png"
    event.attach_file File.open("out.png", "r")
  else
    shame event.message
  end
end

bot.run
