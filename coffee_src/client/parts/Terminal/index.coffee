import { Component } from 'react'
import h from 'react-hyperscript'
import { Terminal } from 'xterm'

term_size_list = [
  cols: 80
  rows: 24
,
  cols: 100
  rows: 40
]

export default class TermWindow extends Component
  constructor: (props)->
    super arguments...
    @socket = props.socket
    @state =
      term_size_index: 0
  componentDidMount: ()=>
    term_size = term_size_list[@state.term_size_index]
    term = new Terminal
      cols: term_size.cols
      rows: term_size.rows
    @term = term

    if @socket
      @socket.on 'connect', (d)=>
        term.open document.getElementById 'terminal'
        term.on 'data', (d)=> @socket.emit 'data', d
      @socket.on 'data', (d)=> term.write d
      @socket.on 'disconnect', ()->
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
    term_header_height = 36
    term_width = term_size_list[@state.term_size_index].cols * 9
    term_height = term_size_list[@state.term_size_index].rows * 17
    h 'div',
      style:
        display: 'flex'
    , [
        h 'div', [
          h '.bg-secondary.text-light',
            key: 'title'
            style:
              width: "#{term_width}px"
              height: "#{term_header_height}px"
              display: 'flex'
              justifyContent: 'space-between'
              alignItems: 'baseline'
          , [
              h 'h4', 'Terminal'
              h 'span.badge.badge-light',
                onClick: @resize
              , 'resize'
            ]
          h 'div',
            key: 'terminal'
            style:
              width: "#{term_width}px"
              height: "#{term_height}px"
          , [
              h '#terminal', key: 'terminal'
            ]
        ]
        h 'div',
          style:
            flex: 1
            height: "#{term_height+term_header_height}px"
        , [
            h 'div', [
              'Helper'
            ]
          ]
      ]

