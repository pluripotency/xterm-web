express = require 'express'
app = express()
config = require './config'

webpack = require('webpack')
webpackDevMiddleware = require('webpack-dev-middleware')
webpackHotMiddleware = require('webpack-hot-middleware')
webpackConfig = require('./webpack.config')
compiler = webpack(webpackConfig)

# Tell express to use the webpack-dev-middleware and use the webpack.config.js
# configuration file as a base.
app.use webpackDevMiddleware compiler,
   noInfo: false,
  publicPath: webpackConfig.output.publicPath
app.use webpackHotMiddleware compiler

server = require('../server/app').init(app)

server.listen config.port, ()-> console.log "devserver listening on port #{config.port}"
