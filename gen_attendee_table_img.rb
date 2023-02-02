require "erb"
require "RMagick2"

svg_template = ERB.new File.read "./TableTemplate.svg.erb"

people = {
  "jcmb" => ["Luke", "Lucas"],
  "bayes" => ["Hannah", "Patrick"]
}

img = Magick::Image.from_blob(svg_template.result binding) {
  format= 'SVG'
  background_color='#2c2f33' # from discord colour palette
}

img[0].write "out.png"
