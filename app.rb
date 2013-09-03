require 'sinatra/base'
require 'sinatra/activerecord'
#require 'sinatra/flash'
require 'sinatra/contrib/all'
require 'sinatra/assetpack'
#require 'json'
#require 'i18n'
#require 'will_paginate'
#require 'will_paginate/active_record'

#I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config/locales', '*.yml').to_s]

class PrivateReader < Sinatra::Base
  configure do
    set :database_file, 'config/database.yml'
    #set :views, 'app/views'
    set :public_dir, 'public'
    set :root, File.dirname(__FILE__)

    #enable :sessions
    #set :session_secret, ENV['SECRET_TOKEN'] || 'secret!'
    #enable :logging

    register Sinatra::ActiveRecordExtension
    #register Sinatra::Flash
    register Sinatra::Contrib
    register Sinatra::AssetPack

    ActiveRecord::Base.include_root_in_json = false
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
