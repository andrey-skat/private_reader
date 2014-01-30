require 'rubygems'
require 'bundler'
require 'active_support/time_with_zone'
Bundler.require(:default)

#I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config/locales', '*.yml').to_s]
class PrivateReader < Sinatra::Base
  before do
    #content type for all responses is json
    content_type :json
  end

  configure do
	  register Sinatra::AssetPack
    register Sinatra::ActiveRecordExtension
    register Sinatra::Contrib    

    set :database_file, 'config/database.yml'
    set :views, 'app/views'
    set :public_dir, 'public'
    set :root, File.dirname(__FILE__)

    #set :sass, load_paths: %W(#{settings.root}/public/css/)

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
    #serve '/images', from: 'public/images'

    js :application, '/js/application.js', %w(
        /js/libs/*.js
        /js/*.js
    )

    #css :application, '/css/application.css', %w(
    #   /css/main.sass
    #)

    js_compression  :jsmin
    css_compression :sass

    #prebuild true unless ENV['RACK_ENV'] == 'test'
  end

  get '/' do
    redirect '/index.html'
  end

	get '/css/application.css' do
		content_type :css
		Sass.compile_file('public/css/main.sass')
	end
end

require_relative 'app/controllers/channel_controller'
require_relative 'app/controllers/articles_controller'
