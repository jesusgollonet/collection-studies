var container = document.getElementById('main');
container.style.width = '500px';
container.style.height = '500px';
Elm.Main.embed(container);
var cnv = container.getElementsByTagName('canvas')[0];

var xhr = new XMLHttpRequest();
xhr.open('POST', '/api/save');
xhr.setRequestHeader('Content-Type', 'application/json');
xhr.onload = function(){
    console.log(JSON.parse(xhr.response));
};

document.addEventListener('keydown', function(e){
    switch (e.keyCode){
        case 32: // space
            sendCanvas();
            break;
    }
});

function sendCanvas (){
    xhr.send(JSON.stringify({
        image: cnv.toDataURL()
    }));
}
