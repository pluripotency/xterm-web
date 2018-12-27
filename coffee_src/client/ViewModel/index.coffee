import io from 'socket.io-client'
import { Terminal } from 'xterm'

term_size_list = [
  cols: 80
  rows: 24
,
  cols: 100
  rows: 40
]

vm =
  socket: null
  start_socket: (callback)->
    socket = io()
    socket.on 'connect', ()-> console.log "connected: #{socket.id}"
    socket.on 'disconnect', ()-> console.log "disconnected"
    vm.socket = socket
    if typeof callback == 'function'
      callback()
  stop_socket: (callback)->
    if vm.socket?
      vm.socket.disconnect()
      vm.socket = null
    if typeof callback == 'function'
      callback()
  term: null
  cols: 80
  rows: 24
  start_xterm: (callback)->
    term_size = term_size_list[0]
    vm.term = new Terminal
      cols: term_size.cols
      rows: term_size.rows
    if vm.socket
      vm.socket.on 'connect', ()->
        vm.term.open document.getElementById 'terminal'
        vm.term.on 'data', (d)-> vm.socket.emit 'data', d
      vm.socket.on 'data', (d)-> vm.term.write d
      vm.socket.on 'disconnect', ()->
        console.log "disconnected"
        vm.term.dispose()
    if typeof callback == 'function'
      callback()
  resize_xterm: (new_index, callback)->
    term_size = term_size_list[new_index]
    vm.term.resize term_size.cols, term_size.rows
    vm.cols = term_size.cols
    vm.rows = term_size.rows
    vm.socket.emit 'resize',
      cols: term_size.cols
      rows: term_size.rows
    if typeof callback == 'function'
      callback()
  stop_xterm: (callback)->

    if typeof callback == 'function'
      callback()

export default vm
