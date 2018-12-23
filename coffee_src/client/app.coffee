import React from 'react'
import h from 'react-hyperscript'
#import 'xterm/dist/xterm.css'
import { Terminal } from 'xterm'
import * as fit from 'xterm/lib/addons/fit/fit'
Terminal.applyAddon fit
import io from 'socket.io-client'

term_size_list = [
  cols: 80
  rows: 24
,
  cols: 120
  rows: 60
]

export default class App extends React.Component
  constructor: (props)->
    super arguments...
    @state =
      term_size_index: 0
  componentDidMount: ()=>
    socket = io()
    @socket = socket
    term_size = term_size_list[@state.term_size_index]
    term = new Terminal
      cols: term_size.cols
      rows: term_size.rows
#    term.fit()
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
    if @state.term_size_index == 0
      new_index = 1
    else
      new_index = 0
    term_size = term_size_list[new_index]
    @term.resize term_size.cols, term_size.rows
    @socket.emit 'resize',
      cols: term_size.cols
      rows: term_size.rows
    @setState term_size_index: new_index
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
                  width: "#{term_size_list[@state.term_size_index].cols * 9}px"
                  height: "#{term_size_list[@state.term_size_index].rows * 17}px"
                , [
                  h '#terminal', key: 'terminal'
                ]
            ]
          ]
        ]
      ]
    ]
