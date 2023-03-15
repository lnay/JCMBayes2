require "discordrb"
require "erb"
require "RMagick2"
require "yaml"

BOT_TOKEN, CHANNEL_ID = YAML.load_file("auth.yml")
                            .values_at("token", "channel")
puts "The Bot Token is #{BOT_TOKEN}"
puts "The channel ID is #{CHANNEL_ID}"

LOCATIONS = ["JCMB", "Bayes"]
# Hash associating each location to an empty list (to fill with attendees)
$people = LOCATIONS.map{ |loc| [loc.downcase, []] }.to_h

def s_h_a_m_e message
  shame_reaccs = ['🇸', '🇭', '🇦', '🇲', '🇪', '👹']
  shame_reaccs.each &message.method(:create_reaction)
  sleep 10
  total_shame = shame_reaccs.map{|reacc| message.reacted_with(reacc).length}.sum
  message.respond "Total shame reaccs for #{message.author.display_name}: #{total_shame}"
  message.delete
end

def gen_table_img filename
  svg_template = ERB.new File.read "./TableTemplate.svg.erb"
  img = Magick::Image.from_blob(svg_template.result binding) { format="SVG" }
  img[0].write filename
end

PERMISSIBLE_MESSAGE = /^
  (?<location>#{LOCATIONS.join("|")}) # start with one location
  (\s+[a-z0-9_\-:\.]+)? # Followed by optional extra, separated by a space
  [!?]? # End with optional punctuation
$/ix

bot = Discordrb::Bot.new token: BOT_TOKEN

bot.message() do |event|
  return 0 unless event.channel.id == CHANNEL_ID
  if event.content =~ PERMISSIBLE_MESSAGE
    location = $~[:location].downcase
    name = event.author.display_name
    $people[location] << name unless $people[location].include?(name)
    gen_table_img "out.png"
    event.attach_file File.open("out.png", "r")
  elsif event.content == "!clear"
    $people["jcmb"] = []
    $people["bayes"] = []
  elsif event.content == "!rules"
    event.message.respond "Permissible messages: '!clear', '!rules' and anything matching the following regex #{PERMISSIBLE_MESSAGE}"
  else
    s_h_a_m_e event.message
  end
end

bot.run
