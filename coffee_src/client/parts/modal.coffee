h = require 'react-hyperscript'
React = require 'react'

example =
  theme: '.bg-primary'
  modal_size: 'lg'
  title: 'title'
  body: 'body'
  close_func: ()=>

class Modal extends React.Component
  render: ()=>
    theme = @props?.theme or '.bg-primary'
    modal_size = if @props?.modal_size? then ".modal-#{@props?.modal_size}" else ''
    h 'div', [
      h '.modal.fade.show',
        style:
          overflow: 'scroll'
          display: 'block'
      , [
          h ".modal-dialog#{modal_size}.fade-in.slide-in-top", [
#          h ".modal-dialog", [
            h '.modal-content', [
              h ".modal-header#{theme}", [
                h 'h4.modal-title', @props.title
                if @props?.close_func?
                  h 'label.close', onClick: @props.close_func, [h 'span', 'x']
              ]
              h '.modal-body', @props.body
              if @props?.footer?
                h '.modal-footer', @props.footer
            ]
          ]
        ]
      h '.modal-backdrop.fade.show'
    ]

module.exports = Modal

