module.exports =
  init: (app)=>
    express = require 'express'
    path = require 'path'
    fs = require 'fs'
    options =
      pfx: fs.readFileSync path.resolve __dirname, '../../server.pfx'
      passphrase: '3xp0rt!'
    server = require('https').createServer options, app
    IO = require 'socket.io'
    pty = require 'pty.js'


    app.use express.static path.resolve __dirname, '../../public'
    app.use '/xterm.js', express.static path.resolve __dirname, '../../node_modules/xterm'
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

