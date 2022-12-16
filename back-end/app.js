require('dotenv').config()
var express = require('express');

var temperaturesRouter = require('./routes/temperatures');

var app = express();

app.use(express.json());
app.use('/temperatures', temperaturesRouter);

module.exports = app;
