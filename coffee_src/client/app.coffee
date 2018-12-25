import {Component} from 'react'
import h from 'react-hyperscript'

import {NavBar, NavList} from './parts/navbar'
import vm from './ViewModel/index'
vm.start_socket()

import TermWindow from './parts/Terminal/index'

export default class App extends Component
  constructor: (props)->
    super arguments...
    @state =
      nav_index: 0
  render: ()=>
    h 'div', [
      h '.container-fluid',
        style:
          margin: 0
          padding: 0
      , [
        h NavBar,
          title: 'xterm-web'
        , [
          h NavList,
            nav_index: @state.nav_index
            nav_list: [

            ]
            select_nav: ()->
          ]
        ]
      h TermWindow,
        socket: vm.socket
    ]
