path = require('path')
config = require './config'
HtmlWebpackPlugin = require('html-webpack-plugin')
CleanWebpackPlugin = require('clean-webpack-plugin')
webpack = require('webpack')
hotMiddlewareScript = 'webpack-hot-middleware/client?path=http://localhost:3000/__webpack_hmr&timeout=20000&reload=true'

module.exports =
    mode: 'development'
    entry:
      main: ['./js/client/index.js', hotMiddlewareScript]
    devtool: 'inline-source-map'
    devServer:
      contentBase: './dist'
      hot: true
    plugins: [
      new CleanWebpackPlugin(['dist'])
      new HtmlWebpackPlugin
        title: config.html_title
        template: path.resolve __dirname, '../../index.html'
      new webpack.NamedModulesPlugin(),
      new webpack.HotModuleReplacementPlugin()
      new webpack.NoEmitOnErrorsPlugin()
    ]
    output:
      filename: '[name].bundle.js'
      path: path.resolve(__dirname, 'dist')
      publicPath: '/'
