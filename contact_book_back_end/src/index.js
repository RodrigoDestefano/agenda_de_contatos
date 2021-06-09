require('./database');

const express = require('express');
const routes = require('./routes.js');
const app = express();

app.use(express.json());
app.use(routes);

// Port listening...
app.listen(8000);