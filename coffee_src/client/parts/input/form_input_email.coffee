h = require 'react-hyperscript'
React = require 'react'

form_input = require './form_input'


class EmailInput extends React.Component
  render: ()=>
    h form_input,
      labelWidth: 3
      inputWidth: 9
      onChange: @props.onChange
      validate: (value)=> value.match /.+@.+/
      invalidMessage: 'Invalid email format'
      inputType: 'email'
      label: 'Email'
      placeholder: 'Email'

module.exports = EmailInput
