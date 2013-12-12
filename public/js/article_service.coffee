angular.module("articleServices", ["ngResource"])
	.factory("Article", ($resource) ->
		$resource "articles/:id", {},
			query:
        method: "GET"
        isArray: true
      get:
        method: "GET"
        params:
          id: "id"
      for_channel:
        url: "/channels/:channel_id/articles"
        method: "GET"
        isArray: true
        params:
          channel_id: "channel_id"
	)