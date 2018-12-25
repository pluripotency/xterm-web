h = require 'react-hyperscript'
React = require 'react'

class NavList extends React.Component
  constructor: (props)->
    super arguments...
  select_nav: (index)=>(e)=>
    e.preventDefault()
    @props.select_nav(index)
  render: ()=>
    h 'ul.navbar-nav.mr-auto', @props.nav_list.map (item, i)=>
      h 'li.nav-item',
        className: if @props.nav_index == i then 'active'
      , [
          h 'a.nav-link',
            onClick: @select_nav(i)
          , item.name
        ]

class NavDropDownLeft extends React.Component
  constructor: (props)->
    super arguments...
    @state =
      menu_list: props.menu_list
      collapse: true
  toggle: (e)=>
    e.preventDefault()
    @setState collapse: !@state.collapse
  componentWillReceiveProps: (nextProps)=>
    if nextProps.menu_list?
      @setState menu_list: nextProps.menu_list
  render: ()=>
    h '.btn-group.dropleft', [
      h 'label.btn.btn-outline-secondary',
        className: if @state.collapse then '' else 'show'
        onClick: @toggle
      , [
          h 'i.fa.fa-cog.text-light'
          if @state.collapse
            ''
          else
            h '.dropdown-menu.show', @state.menu_list.map (item)=>
              if item[0] == 'div'
                h '.dropdown-divider'
              else if item[0] == 'component'
                item[1]
              else
                h 'a.dropdown-item',
                  onClick: item[1]
                , item[0]
      ]
    ]


class NavBar extends React.Component
  constructor: (props)->
    super arguments...
    @state = collapse: true
  toggle: (e)=>
    e.preventDefault()
    @setState collapse: !@state.collapse
  render: ()=>
    document.title = @props.title
    h "nav.navbar.navbar-expand-md.bg-dark.navbar-dark",
      style: zIndex: 1
    , [
      h 'a.navbar-brand.text-light', @props.title
      h 'button.navbar-toggler',
        onClick: @toggle
      , [h 'span.navbar-toggler-icon']
      h '.navbar-collapse',
        className: if @state.collapse then 'collapse' else 'in'
      , @props.children
    ]

module.exports =
  NavBar: NavBar
  NavList: NavList
  NavDropDownLeft: NavDropDownLeft
