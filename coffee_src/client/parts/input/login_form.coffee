h = require 'react-hyperscript'
React = require 'react'

Card = require '../card'
Modal = require '../modal'
EmailInput = require './form_input_email'
PasswordInput = require './form_input_password'


class EmailLogin extends React.Component
  constructor: ->
    super()
    @state =
      email: ''
      password: ''
      error: false
  onEmailChange: (value)=>
    @setState
      email: value
  onPasswordChange: (value)=>
    @setState
      password: value
  onSubmit: (e)=>
    e.preventDefault()
    @props.submit @state.email, @state.password, (err)=>
      if err
        @setState error: err
      else
        @setState error: false

  render: ()=>
    h 'form.form-horizontal', [
      h EmailInput, onChange: @onEmailChange
      h PasswordInput, onChange: @onPasswordChange
      h 'div',
        style:
          display: 'flex'
          justifyContent: 'flex-end'
      , [
          h 'button.btn.btn-primary',
            type: 'submit'
            onClick: @onSubmit
          , 'Submit'
        ]
        if @state.error
          h '.alert.alert-danger', @state.error
    ]

mock_login_submit = (email, password, cb)=>
  if email == 'a@bc.local' and password == 'password'
    cb null
  else
    cb 'Invalid email or password'

class ModalLoginForm extends React.Component
  constructor: ->
    super()
    @state = open: false
  render: =>
    if @state.open
      h Modal,
        modal_size: ''
        title: 'Login Modal'
        body: [
          h EmailLogin,
            submit: mock_login_submit
        ]
        close_func: ()=> @setState open:false
    else
      h 'label.btn.btn-primary',
        onClick: ()=> @setState open: true
      , 'Modal Login'

module.exports =
  Login: class LoginForm extends React.Component
    render: ()=>
      h 'div',
        style:
          display: 'flex'
          justifyContent: 'center'
#          alignContent: 'center'
      , [
          h 'div',
            style:

              width: '400px'
              height: '200px'
          , [
              h 'h3', 'Login'
              h EmailLogin
            ]
        ]
