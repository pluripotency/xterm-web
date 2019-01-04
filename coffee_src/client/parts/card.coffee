h = require 'react-hyperscript'
React = require 'react'

class Card extends React.Component
  render: ()=>
    h ".card",
      className: do=>
        theme = ""
        if @props.theme?
          theme = "bg-#{@props.theme}"
        text_theme = ""
        if @props.text_theme?
          text_theme = "text-#{@props.text_theme}"
        border_theme = ""
        if @props.border_theme?
          border_theme = "border-#{@props.border_theme}"
        "#{theme} #{text_theme} #{border_theme}"
    , [
        'header'
        'body'
        'footer'
      ].map (position)=>
        if @props[position]?.text?
          h ".card-#{position}",
            className: do=>
              theme = ''
              if @props[position].theme?
                theme = "bg-#{@props[position].theme}"
              text_theme = ''
              if @props[position].text_theme?
                text_theme = "text-#{@props[position].text_theme}"
              "#{theme} #{text_theme}"
          , @props[position].text

module.exports = Card

