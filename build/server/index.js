var express = require('express');
var bodyParser = require('body-parser');
var fs = require('fs');
var app = express();

app.use(bodyParser.json({limit: '5mb'}));
app.use(bodyParser.urlencoded({extended:true, limit:'5mb'}));

app.use(express.static('public'));

app.listen(3000, () => {
    console.log('Server up and listening on port 3000');
});

app.post('/api/save', (req, res) => {
    // generate timestamp
    var data = req.body.image.replace(/^data:image\/\w+;base64,/, '');
    var imgName = (new Date()).getTime() + '.png';
    fs.writeFile('output/' + imgName, data, {encoding: 'base64'}, (err) => {
        //Finished
        console.log('finished');
    });
    res.json(req.body);
});

