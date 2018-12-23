express = require 'express'
app = express()
config = require './config'

server = require('./app').init(app)

server.listen config.port, ()-> console.log "server listening on port #{config.port}"
