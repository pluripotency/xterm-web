
vm =
  socket: null
  start_socket: ()->
    io = require 'socket.io-client'
    socket = io()
    socket.on 'connect', ()-> console.log "connected: #{socket.id}"
    socket.on 'disconnect', ()-> console.log "disconnected"
    vm.socket = socket
  stop_socket: ()->
    if vm.socket?
      vm.socket.disconnect()
      vm.socket = null

export default vm
