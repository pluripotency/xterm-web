import React from 'react'
import ReactDom from 'react-dom'
import LoginForm from './parts/input/login_form'

component = ()->
  element = document.createElement('div')
  element.id = 'root'
  element

element = component()
document.body.appendChild(element)
ReactDom.render React.createElement(LoginForm.Login), document.getElementById('root')

if module.hot
  module.hot.accept './app', ()->
    console.log 'Accepting the updated module'
    document.body.removeChild element
    element = component()
    document.body.appendChild element
    ReactDom.render React.createElement(LoginForm.Login), document.getElementById('root')

