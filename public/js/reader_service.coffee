angular.module("readerServices", ["channelServices", "articleServices"])
  .factory("Reader", (Channel, Article) ->
    {
      current_channel: null
      articles: ->
        if this.current_channel == null
          Article.query()
        else
          Article.for_channel({channel_id: this.current_channel.id})
      channels: ->
        list = Channel.query({}, (response) =>
          this.current_channel = response[1] if response.length > 0 and this.current_channel == null
        )
        list
    }
  )