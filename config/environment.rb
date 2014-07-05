# Load the Rails application.
require File.expand_path('../application', __FILE__)

if $0 == 'irb'
  require 'hirb'
  Hirb.enable
end
# Initialize the Rails application.
Rails.application.initialize!

