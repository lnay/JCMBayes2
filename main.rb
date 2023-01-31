require 'discordrb'
require 'yaml'

auth = YAML.load_file("auth.yml")

bot_token = auth["token"]
channel_id = auth["channel"]

puts "The Bot Token is #{bot_token}"
puts "The channel ID is #{channel_id}"

bot = Discordrb::Bot.new token: bot_token

rgx = /^(jcmb|bayes)(\s+[a-z0-9_\-:\.]+)?[!?]?$/i;

bot.message(with_text: rgx) do |event|
  event.respond 'Correct format!'
end

bot.run
