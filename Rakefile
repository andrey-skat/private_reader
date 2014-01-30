require 'sinatra/activerecord/rake'
require 'rubygems'
require 'bundler'

Bundler.require

require './app'

require_relative 'lib/feeds_updater'

task :default do
	puts 'default'
end

desc "Update all feeds"
task :update_all_feeds do
  FeedsUpdater.update_all
end

desc "Subscribe to feed"
task :subscribe, :url do |url|
	Channel.subscribe url
end