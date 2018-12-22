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
    term = new Terminal()
    #term.fit()
    term.open document.getElementById 'terminal'
    term.on 'data', (d)=> socket.emit 'data', d
    socket.on 'connect', ()=> 
      console.log "connected: #{socket.id}"
    socket.on 'data', (d)=> term.write d
    socket.on 'disconnect', ()-> 
      console.log "disconnected"
      term.dispose()
  render: ()=>
    h 'div', [
      h '.rows', [
        h '.col-9', [
          h '.card', [
            h '.card-header', [
              h 'h1', key: 'title', 'Hello Coffee World'
            ]
            h '.card-body.card-primary', [
              h 'div',
                style:
                  width: '720px'
                  height: ''408px
                , [
                  h '#terminal', key: 'terminal'
                ]
            ]
          ]
        ]
      ]
    ]
