require 'discordrb'
require 'yaml'

auth = YAML.load_file("auth.yml")

bot_token = auth["token"]
channel_id = auth["channel"]

puts "The Bot Token is #{bot_token}"
puts "The channel ID is #{channel_id}"

bot = Discordrb::Bot.new token: bot_token

people = {
  "jcmb" => [],
  "bayes" => [],
}

def shame(message)
  reactions = ['🇸', '🇭', '🇦', '🇲', '🇪', '👹']
  reactions.each do |reacc|
    message.create_reaction reacc
  end

  sleep 10
  message.delete
end

rgx = /^(?<location>jcmb|bayes)(\s+[a-z0-9_\-:\.]+)?[!?]?$/i;

bot.message() do |event|
  # event.respond "S H A M E" unless event.content =~ rgx
  # event.respond "Location: #{$~['location']}" if $~
  match_data = rgx.match(event.content)
  if match_data
    location = match_data['location']
    event.respond "Location: #{location}"
    name = event.author.display_name
    location_attendees = people[location.downcase]
    location_attendees << name unless location_attendees.include?(name)
    puts people
  else
    shame event.message
  end
end

bot.run
