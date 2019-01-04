path = require('path')
config = require './config'
HtmlWebpackPlugin = require('html-webpack-plugin')
CleanWebpackPlugin = require('clean-webpack-plugin')
webpack = require('webpack')

module.exports =
  mode: 'production'
  entry:
    main: [path.resolve(__dirname, '../client/index.js')]
    login: [path.resolve(__dirname, '../client/login.js')]
  plugins: [
    new CleanWebpackPlugin ['dist'],
      root: path.resolve __dirname, '../../public'
    new HtmlWebpackPlugin
      chunks: ['main']
      template: path.resolve __dirname, '../../index.html'
    new HtmlWebpackPlugin
#        inject: true
      chunks: ['login']
      filename: 'login.html'
      template: path.resolve __dirname, '../../login.html'
  ]
  output:
    filename: '[name].js'
    path: path.resolve __dirname, '../../public/dist'
    publicPath: '/dist/'
