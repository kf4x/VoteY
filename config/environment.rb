# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mytestproject::Application.initialize!

# Date time
Date::DATE_FORMATS[:datehelper] = '%d/%m/%Y'
Time::DATE_FORMATS[:datehelper] = '%A %B %d %Y at %I:%M%p'