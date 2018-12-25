express = require 'express'
app = express()
fs = require 'fs'
path = require 'path'
options =
  pfx: fs.readFileSync path.resolve __dirname, '../../server.pfx'
  passphrase: '3xp0rt!'
server = require('https').createServer options, app
config = require './config'

server = require('./app').init(app, server)

server.listen config.port, ()-> console.log "server listening on port #{config.port}"
