require 'dragonfly'
 
app = Dragonfly[:images]
app.configure_with(:imagemagick)
app.configure_with(:rails)
 
app.define_macro(ActiveRecord::Base, :image_accessor)
 
app.configure do |c|
  c.convert_command = "/opt/local/bin/convert"          # defaults to "convert"
  c.identify_command = "/opt/local/bin/identify"        # defaults to "identify"
  c.log_commands = true                                 # defaults to false
end