# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
ENV['GEM_PATH'] = '/home/jujudell/ruby/gems:/usr/lib/ruby/gems/1.8'
ENV['RAILS_ENV'] ||= 'production'



# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '1.2.6' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  config.frameworks -= [ :action_web_service ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Include your application configuration below
PASSWORD_SALT = '48e45be7dj47szb0ab582d26e2168621' unless Object.const_defined?(:PASSWORD_SALT)


# monkey patch redcloth

Module.class_eval do
  def expiring_attr_reader(method_name, value)
    class_eval(<<-EOS, __FILE__, __LINE__)
      def #{method_name}
        class << self; attr_reader :#{method_name}; end
        @#{method_name} = eval(%(#{value}))
      end
    EOS
  end
end

WhiteListHelper.tags.merge(%w(object param embed))

# Include your application configuration below
FLICKR_API_KEY='e48761621b45a4c08dd27ac5de4e6764'
FLICKR_USER_ID='59226685@N00'
BDAY='2-jan-1973'.to_date


include Globalize
Locale.set_base_language 'fr-FR'
LOCALES = {'fr' => 'fr-FR',
           'de' => 'de-DE',
           'en' => 'en-US'}
MENU_LOCALES="fr de en".split(" ")

CMS_ICONS ={
  'edit'=>'/images/icons/kate.png',
  'pencil'=>'/images/icons/pencil.png',
  'password'=>'/images/icons/password.png',
  'code'=>'/images/icons/konsole.png',
  'delete'=>'/images/icons/cancel.png',
  'add_child'=>'/images/icons/window_list.png',
  'updown'=>'/images/icons/updownarrow.png',
  'cfmd'=>'/images/icons/ledgreen.gif',
  'clx'=>'/images/icons/ledred.gif',
  'image_new'=>'/images/icons/image_new.gif',
  'attach'=>'/images/icons/attach.png',
  'attach_new'=>'/images/icons/new_attach.gif',
  'print'=>'/images/icons/print.gif',
  'visible'=>'/images/icons/icon_visible.gif',
  'comment'=>'/images/icons/comment.gif',
  'no-comment'=>'/images/icons/no-comment.gif'
}          


unless '1.9'.respond_to?(:force_encoding)
  String.class_eval do
    begin
      remove_method :chars
    rescue NameError
      # OK
    end
  end
end

MY_CONFIG = {
  :flickr_cache_file => "#{RAILS_ROOT}/config/flickr.cache",
  :flickr_key => "e48761621b45a4c08dd27ac5de4e6764",
  :flickr_shared_secret => "ba884f7208e37845",
  :flickr_id => "46484477@N00",
  :rflickr_lib => true
}
#require 'flickr'

