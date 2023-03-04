# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

#so that we remove field error proc and dont mess with our design bcoz we have our own error msg div
#also after add these lines restart your server
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
