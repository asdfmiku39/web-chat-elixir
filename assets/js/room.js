import {Socket} from 'phoenix';

var roomname = sessionStorage.getItem('roomname');
var name = sessionStorage.getItem('nickname'); 

let socket = new Socket('/socket', 
  { params: { nickname: name, roomname: roomname} });
socket.connect();

let channel = socket.channel('room:'+ roomname, 
  {params: {nickname: name, roomname: roomname}});

channel.on('shout', function (payload) {
  var li = document.createElement("li");
  var name = payload.name;
  li.innerHTML = '<b>' + name + '</b>: ' + payload.message;
  ul.appendChild(li);
});

channel.join();
var ul = document.getElementById('msg-list');
var msg = document.getElementById('msg');

msg.addEventListener('keypress', function (event) {
  if (event.keyCode == 13 && msg.value.length > 0) {
    channel.push('shout', msg.value );
    msg.value = '';
  }
});
