require 'sinatra/activerecord/rake'
require 'rubygems'
require 'bundler'

Bundler.require

require './app'

require_relative 'lib/feeds_updater'

desc "Update all feeds"
task :update_all_feeds do
  FeedsUpdater.update_all
end