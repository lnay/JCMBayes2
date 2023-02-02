require "erb"
require "RMagick2"

svg_template = ERB.new File.read "./TableTemplate.svg.erb"

attendee1 = "Luke"
attendee2 = "Hannah"
attendee3 = "Patrick"

img = Magick::Image.from_blob(svg_template.result binding) {
  format= 'SVG'
  background_color='#2c2f33' # from discord colour palette
}

img[0].write "out.png"
