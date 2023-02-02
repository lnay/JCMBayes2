require "erb"

svg_template = ERB.new File.read "./TableTemplate.svg.erb"

attendee1 = "Luke"
attendee2 = "Hannah"
attendee3 = "Patrick"

puts svg_template.result binding
