import React from 'react'
import ReactDom from 'react-dom'
import App from './app'

component = ()->
  element = document.createElement('div')
  element.id = 'root'
  element

element = component()
document.body.appendChild(element)
ReactDom.render React.createElement(App), document.getElementById('root')

if module.hot
  module.hot.accept './app', ()->
    console.log 'Accepting the updated module'
    document.body.removeChild element
    element = component()
    document.body.appendChild element
    ReactDom.render React.createElement(App), document.getElementById('root')

