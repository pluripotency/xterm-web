path = require('path')
config = require './config'
HtmlWebpackPlugin = require('html-webpack-plugin')
CleanWebpackPlugin = require('clean-webpack-plugin')
webpack = require('webpack')
hotMiddlewareScript = "webpack-hot-middleware/client?path=http://localhost:#{config.port}/__webpack_hmr&timeout=20000&reload=true"

module.exports =
    mode: 'development'
    entry:
      main: [path.resolve(__dirname, '../client/index.js'), hotMiddlewareScript]
      login: [path.resolve(__dirname, '../client/login.js'), hotMiddlewareScript]
    devtool: 'inline-source-map'
    devServer:
#      contentBase: './dist'
#      contentBase: './public'
#      contentBase: path.resolve __dirname, '../../public/dist'
      hot: true
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
      new webpack.NamedModulesPlugin(),
      new webpack.HotModuleReplacementPlugin()
      new webpack.NoEmitOnErrorsPlugin()
    ]
    output:
      filename: '[name].js'
#      path: path.resolve(__dirname, '../../public/dist')
#      publicPath: '/'
#      path: path.resolve __dirname, '../../public/dist'
#      publicPath: '/dist'
