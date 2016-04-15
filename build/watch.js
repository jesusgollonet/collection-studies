var chokidar = require('chokidar');
var exec = require('child_process').exec;

// One-liner for current directory, ignores .dotfiles
chokidar.watch('elm/Main.elm', {ignored: /[\/\\]\./}).on('change', (path) => {
  console.log(path, 'changed');
  var cmd = 'pwd && (cd elm && elm-make Main.elm   --output=../public/js/elm.js)';
  exec(cmd, function(error, stdout, stderr) {
      console.log(error, stdout, stderr);
      // command output is in stdout
  });
});
