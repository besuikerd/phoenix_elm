var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: {
    app: "./web/static/js/app.js",
  },

  output: {
    name: 'app',
    path: "./priv/static/js",
    filename: "app.js"
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel",
        query: {
          presets: ["es2015"]
        }
      },

      {test: /\.css$/,   loader: ExtractTextPlugin.extract('style-loader', 'css')},
      {test: /\.scss$/i, loader: ExtractTextPlugin.extract('style-loader', ['css','sass'])},
      {test: /\.less$/i, loader: ExtractTextPlugin.extract('style-loader', ['css','less'])},

      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack'
      },
    ]
  },

  resolve: {
    modulesDirectories: [ "node_modules", __dirname + "/web/static/js", __dirname + "/web/static" ]
  },

  plugins: [
    new ExtractTextPlugin('../css/[name].css')
  ]
}
