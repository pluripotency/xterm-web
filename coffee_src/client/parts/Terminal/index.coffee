import { Component } from 'react'
import h from 'react-hyperscript'

export default class TermWindow extends Component
  constructor: (props)->
    super arguments...
    @vm = props.vm
    @state =
      term_size_index: 0
  componentDidMount: ()=>
    @vm.start_socket ()=>
      @vm.start_xterm ()=>
  resize: ()=>
    if @state.term_size_index == 0
      new_index = 1
    else
      new_index = 0
    @vm.resize_xterm new_index, ()=>
      @setState term_size_index: new_index
  render: ()=>
    term_header_height = 36
    term_width = @vm.cols * 9
    term_height = @vm.rows * 17
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

