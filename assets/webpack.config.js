const path = require('path');
const webpack = require('webpack');
const env = process.env.MIX_ENV || 'dev';
const prod = env === 'prod';

if (prod) {
    throw 'Prod not ready yet!';
}

const publicPath = 'http://localhost:4001/';
const entryPath = './ts/app.ts';

module.exports = {
    resolve: {
        extensions: ['.js', '.ts', '.elm', '.css', '.scss'],
        alias: {
            phoenix_html: '../deps/phoenix_html/priv/static/phoenix_html',
            phoenix: '../deps/phoenix/priv/static/phoenix'
        }
    },
    context: __dirname,
    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new webpack.NamedModulesPlugin(),
    ],
    entry: {
        app: [
            `webpack-dev-server/client?${publicPath}`,
            'webpack/hot/only-dev-server',
            entryPath
        ]
    },
    output: {
        path: path.resolve(__dirname, './dist'),
        filename: '[name].bundle.js',
        publicPath
    },
    devServer: {
        stats: 'errors-only'
    },
    module: {
        rules: [
            {
                test: /\.scss$/,
                use: [
                    "style-loader",
                    "css-loader",
                    "sass-loader"
                ]
            },
            {
                test: /\.css$/,
                use: [
                    'style-loader',
                    'css-loader?modules'
                ],
            },
            {
                test: /\.ts$/,
                use: [
                    'awesome-typescript-loader'
                ]
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader:  'elm-hot-loader!elm-webpack-loader?verbose=true&warn=true&debug=true&pathToMake=./node_modules/.bin/elm-make'
            },
        ],
        noParse: /\.elm$/
    }
};