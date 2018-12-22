path = require('path')
config = require './config'
CleanWebpackPlugin = require('clean-webpack-plugin')
HtmlWebpackPlugin = require('html-webpack-plugin')
webpack = require('webpack')

module.exports =
    mode: 'production'
    entry: './js/client/index.js'
    plugins: [
      new CleanWebpackPlugin(['dist'])
      new HtmlWebpackPlugin
        title: config.html_title
        template: path.resolve __dirname, '../../index.html'
    ]
    output:
      filename: '[name].bundle.js'
      path: path.resolve __dirname, '../../public/dist'
      publicPath: '/dist/'
