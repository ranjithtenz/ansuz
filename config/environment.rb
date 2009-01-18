# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# Create log directory if it doesn't exist
unless( File.directory?( File.join(RAILS_ROOT, "log") ) )
  STDOUT.puts "Creating log directory.."
  FileUtils.mkdir( File.join(RAILS_ROOT, "log") )
end

# engines
require File.join(File.dirname(__FILE__), '../vendor/plugins/engines/boot')

require 'ansuz'

# Initialize the Ansuz Plugin Manager instance
Ansuz::PluginManagerInstance = Ansuz::PluginManager.new

# authorization plugin
AUTHORIZATION_MIXIN           = "object roles"
LOGIN_REQUIRED_REDIRECTION    = { :controller => '/sessions', :action => 'login' }
PERMISSION_DENIED_REDIRECTION = { :controller => '/page', :action => 'indexer', :path => '' }
STORE_LOCATION_METHOD         = :store_location

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "calendar_date_select"
  config.gem 'mislav-will_paginate',
             :version => '~> 2.3.2',
             :lib => 'will_paginate', 
             :source => 'http://gems.github.com'

  config.gem 'rubyist-aasm', :version => '~> 2.0.2', :lib => 'aasm', :source => "http://gems.github.com"
  config.gem 'mocha'

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  config.plugins = [ :has_settings, :stringex, :userstamp, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.active_record.default_timezone = :utc

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_ansuz_session',
    :secret      => '162b3a16098c98e2bd840e5c025acfe2fc9eee6cbef8875570fd3e1b6835fc0b76a79c401d6756c83c6ad95a4dba019f2c37e9c1585751631b88b014844fddc1'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
end
