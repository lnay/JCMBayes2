require 'discordrb'
require 'yaml'

auth = YAML.load_file("auth.yml")

bot_token = auth["token"]
channel_id = auth["channel"]

puts "The Bot Token is #{bot_token}"
puts "The channel ID is #{channel_id}"

bot = Discordrb::Bot.new token: bot_token

rgx = /^(?<location>jcmb|bayes)(\s+[a-z0-9_\-:\.]+)?[!?]?$/i;

bot.message() do |event|
  event.respond "S H A M E" unless event.content =~ rgx
  event.respond "Location: #{$~['location']}" if $~
end

bot.run
