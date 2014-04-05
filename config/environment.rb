# Load the Rails application.
require File.expand_path('../application', __FILE__)

SECRET_CONFIG = YAML.load_file("#{Rails.root}/config/secrets.yml")[Rails.env]

# Initialize the Rails application.
RflUrlShortener::Application.initialize!
