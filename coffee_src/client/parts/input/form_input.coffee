h = require 'react-hyperscript'
React = require 'react'

class InputForm extends React.Component
  constructor: ->
    super arguments...
#    console.log arguments[0].default_text
    @state =
      value: arguments[0].default_text or ''
      valid: true
  onChange: (e)=>
    value = e.target.value
    if @props.validate?
      if @props.validate(value)
        @setState
          value: value
          valid: true
        @props.onChange(value)
      else
        @setState
          valid: false
    else
      @setState
        value: value
      @props.onChange(value)
  render: ()=>
    label_width = @props.labelWidth or 3
    input_width = @props.inputWidth or 9
    if @props.icon?
      input = h '.input-group', [
        h '.input-group-prepend', [
          h '.input-group-text', [
            h "i.fa.fa-#{@props.icon}"
          ]
        ]
        h 'input.form-control',
          type: @props.inputType or 'text'
          onChange: @onChange
          placeholder: @props.placeholder
          value: @state.value
      ]
    else
      input = h 'input.form-control',
        type: @props.inputType or 'text'
        onChange: @onChange
        placeholder: @props.placeholder
        value: @state.value
    h '.form-group.row', [
      h "label.col-sm-#{label_width}.col-form-label", @props.label
      h ".col-sm-#{input_width}", [
        input
      ]
      if @state.valid == false
        h ".col-sm-#{input_width}.col-sm-offset-#{label_width}", [
          h '.alert.alert-warning', @props.invalidMessage or 'invalid format'
        ]
    ]

props_example =
  default_text: ''
  labelWidth: 3
  inputWidth: 9
  onChange: 'function'
  validate: 'function'
  invalidMessage: 'It is Invalid!!!'
  inputType: 'text'
  label: 'Username'
  placeholder: 'Username'
  icon: 'envelope'

module.exports = InputForm
