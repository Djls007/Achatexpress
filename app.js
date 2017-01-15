var express     = require('express');
var app         = express();
var mysql       = require('mysql');
var connection  = mysql.createConnection({
    host: 'localhost',
    user: 'dbuser',
    password: 's3kreee7'
});

app.set('views', __dirname + '/Client/views/');
app.set('view engine', 'twig');

app.get('/', function (req, res) {
    res.render('login.html.twig', {
        message : "thibaut"
    });
});

app.use('/static', express.static('Client'));

app.listen(3000, function () {
    console.log('Application started at http://localhost:3000 !')
});
