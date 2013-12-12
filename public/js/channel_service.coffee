angular.module("channelServices", ["ngResource"])
  .factory("Channel", ($resource) ->
    $resource "channels/:id", {},
      query:
        method: "GET"
        isArray: true
      get:
        method: "GET"
        params:
          id: "id"
  )