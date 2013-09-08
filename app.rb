require 'rubygems'
require 'bundler'
Bundler.require(:default)

#I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config/locales', '*.yml').to_s]

class PrivateReader < Sinatra::Base
  before do
    #content type for all responses is json
    content_type :json
  end

  configure do
    register Sinatra::ActiveRecordExtension
    register Sinatra::Contrib
    register Sinatra::AssetPack

    set :database_file, 'config/database.yml'
    set :views, 'app/views'
    set :public_dir, 'public'
    set :root, File.dirname(__FILE__)

    #enable :sessions
    #set :session_secret, ENV['SECRET_TOKEN'] || 'secret!'
    enable :logging

    #ActiveRecord::Base.include_root_in_json = false
    ActiveRecord::Base.logger = nil
    Rabl.register!
    Rabl.configure do |config|
      config.view_paths = [settings.views]
      config.include_json_root = false
    end
  end

  assets do
    serve '/js',     from: 'public/js'
    serve '/css',    from: 'public/css'
    serve '/images', from: 'public/images'

    js :application, '/js/application.js', %w(
        /js/jquery-min.js,
        /js/bootstrap-min.js
    )

    css :application, '/css/application.css', %w(
        /css/bootstrap-min.css
    )

    js_compression  :jsmin
    css_compression :simple

    prebuild true unless ENV['RACK_ENV'] == 'test'
  end

  get '/' do
    'hello'
  end
end

require_relative 'app/controllers/feeds_controller'
require_relative 'app/controllers/articles_controller'
