express = require 'express'
app = express()
server = require('http').createServer app
IO = require 'socket.io'
pty = require 'pty.js'

path = require 'path'
config = require './config'

app.use express.static path.resolve __dirname, '../../public'
app.use '/xterm.js', express.static path.resolve __dirname, '../../node_modules/xterm'
app.get '/', (req, res)-> res.sendFile path.resolve __dirname, '../../public/dist/index.html'

io = new IO server
io.on 'connect', (socket)=>
  term = pty.spawn 'bash', [],
    name: 'xterm-256color'
    colos: 80
    rows: 24
  term.on 'data', (d)=> socket.emit 'data', d
  socket.on 'data', (d) => term.write(d)
  socket.on 'disconnect', ()=> term.destroy()

server.listen config.port, ()-> console.log "server listening on port #{config.port}"
