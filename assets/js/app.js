// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

 import socket from "./socket"

socket.connect()

// Now that you are connected, you can join channels with a topic:
//let channel = socket.channel("topic:subtopic", {})

//create channel 
let channel = socket.channel("updates:all",{});

//channel pushes
let nbody = $("#newBody");
let ntitle = $("#newTitle");
let puserinfo = $("#user-info");
let puser = puserinfo.data("user_username");
let submit = $("#post-submit");

//likes 
//code influenced by the original code done by Nat Tuck
let handlebars = require("handlebars");

$(function() {
  if (!$("#likes-template").length > 0) {
   //Wrong page.
   return;
  }

  let lt = $($("#likes-template")[0]);
  let code = lt.html();
  let tmpl = handlebars.compile(code);

  let pc = $($("#likes")[0]);
  let path = pc.data("path");
  let po_id = pc.data("post_id");
  
  let bb = $($("#like-button")[0]);
  let u_id = bb.data("user-id");

  function fetch_likes() {
   function got_likes(data) {
	console.log(data);
	let html = tmpl(data);
        pc.html(html);
   }

   $.ajax({
	url: path,
	data: {post_id: po_id},
	contentType: "application/json",
	dataType: "json",
	method: "GET",
	success: got_likes,

   });
  }

  function add_like(){
   let data = {like: {post_id: po_id, user_id: u_id}};

   $.ajax({
	url: path,
	data: JSON.stringify(data),
	contentType: "application/json",
	dataType: "json",
	method: "POST",
	success: fetch_likes,
   });
  }

  bb.click(add_like);

  fetch_likes();
});
