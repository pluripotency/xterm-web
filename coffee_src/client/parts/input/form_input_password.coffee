h = require 'react-hyperscript'
React = require 'react'

form_input = require './form_input'
password_validator = (value)-> value.match /\w{7}\w+/

class PasswordInput extends React.Component
  render: ()=>
    h form_input,
      labelWidth: 3
      inputWidth: 9
      onChange: @props.onChange
      validate: password_validator
      invalidMessage: 'more than 8 charactors.'
      inputType: 'password'
      label: 'Password'
      placeholder: 'Password'

module.exports = PasswordInput
