import React from 'react'
import h from 'react-hyperscript'
#import 'xterm/dist/xterm.css'
import { Terminal } from 'xterm'
import * as fit from 'xterm/lib/addons/fit/fit'
Terminal.applyAddon fit
import io from 'socket.io-client'

export default class App extends React.Component
  constructor: (props)->
    super arguments...
  componentDidMount: ()=>
    socket = io()
    @socket = socket
    term = new Terminal
      cols: 80
      rows: 24
    #term.fit()
    @term = term
    term.open document.getElementById 'terminal'
    term.on 'data', (d)=> socket.emit 'data', d
    socket.on 'connect', ()=> 
      console.log "connected: #{socket.id}"
    socket.on 'data', (d)=> term.write d
    socket.on 'disconnect', ()-> 
      console.log "disconnected"
      term.dispose()
  resize: ()=>
    @term.resize 80, 40
    @socket.emit 'resize',
      cols: 80
      rows: 40
  render: ()=>
    h 'div', [
      h '.rows', [
        h '.col-9', [
          h '.card', [
            h '.card-header', [
              h 'div', key: 'title', 'Hello Coffee World'
              h '.text-right', [
                h 'label.btn.btn-sm.btn-primary',
                  onClick: @resize
                , 'resize'
              ]
            ]
            h '.card-body.card-primary', [
              h 'div',
                key: 'terminal'
                style:
                  width: '720px'
                #  height: ''408px
                , [
                  h '#terminal', key: 'terminal'
                ]
            ]
          ]
        ]
      ]
    ]
