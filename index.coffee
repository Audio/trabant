
api = require './lib/api'
config = require './config'
debug = require('debug') 'tramvaj'

api.createClient config.url, config.credentials, (e, apiClient) ->
    return console.log e if e

    express = require 'express'
    app = express()

    middleware = require('./lib/api.middleware.coffee') apiClient
    app.use middleware.renewSession
    app.use middleware.findEarliest

    app.listen config.port, -> debug "Listening on port #{config.port}"
