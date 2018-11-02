import {Socket} from 'phoenix';

let ul = document.getElementById('room-list');
let socket = new Socket('/socket',  {});
var nickname = document.getElementById('nickname');
var roomname = document.getElementById('roomname');
var button = document.getElementById('button');

socket.connect();

let channel = socket.channel('roomnames',{} );

channel.on('rooms', function (payload) {
  var li = document.createElement("li");
  li.innerHTML = payload.roomname;
  ul.appendChild(li);
});

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

button.addEventListener('click', function (event) {
  sessionStorage.setItem('nickname', nickname.value);
  sessionStorage.setItem('roomname', roomname.value);
});
