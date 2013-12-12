privateReader = angular.module("privateReader", ["channelServices", "articleServices", "ngSanitize"])

class ReaderCtrl
  channels: []
  articles: []
  current_channel: null

  constructor: ($scope, Channel, @Article) ->
    @channels = Channel.query({}, (response) =>
      @set_current_channel(response[1]) if response.length > 0 and @current_channel == null
    )

  set_current_channel: (channel) ->
    @current_channel = channel
    @load_current_channel_articles()

  load_current_channel_articles: () ->
    @articles = @Article.for_channel({channel_id: @current_channel.id}) if @current_channel != null

privateReader.controller("ReaderCtrl", ReaderCtrl);