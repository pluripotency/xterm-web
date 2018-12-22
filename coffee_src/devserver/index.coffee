express = require 'express'
app = express()
server = require('http').createServer app
IO = require 'socket.io'
pty = require 'pty.js'

path = require 'path'
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
#  noInfo: true,
  publicPath: webpackConfig.output.publicPath
app.use webpackHotMiddleware compiler

app.use express.static path.resolve __dirname, '../../public'
app.use '/xterm.js', express.static path.resolve __dirname, '../../node_modules/xterm'

io = new IO server
io.on 'connect', (socket)=>
  term = pty.spawn 'bash', [],
    name: 'xterm-256color'
    colos: 80
    rows: 24
  term.on 'data', (d)=> socket.emit 'data', d
  socket.on 'data', (d) => term.write(d)
  socket.on 'disconnect', ()=> term.destroy()

server.listen config.port, ()-> console.log "devserver listening on port #{config.port}"
