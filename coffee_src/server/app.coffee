express = require 'express'
path = require 'path'
IO = require 'socket.io'
pty = require 'pty.js'

module.exports =
  init: (app, server)=>

    app.use express.static path.resolve __dirname, '../../public'
    app.use '/xterm.js', express.static path.resolve __dirname, '../../node_modules/xterm'
    app.get '/login', (req, res)-> res.sendFile path.resolve __dirname, '../../public/dist/login.html'
    app.get '/', (req, res)-> res.sendFile path.resolve __dirname, '../../public/dist/index.html'

    io = new IO server
    io.on 'connect', (socket)=>
      term = pty.spawn 'bash', [],
        name: 'xterm-256color'
        cols: 80
        rows: 24
      term.on 'data', (d)=> socket.emit 'data', d
      socket.on 'resize', (size) =>
        console.log 'resized'
        term.resize size.cols, size.rows
      socket.on 'data', (d) => term.write(d)
      socket.on 'disconnect', ()=> term.destroy()
    server

