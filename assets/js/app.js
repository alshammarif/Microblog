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

var likes = 0;
let bb = $($("#like-button")[0]);
let pl = $($("#post-likes")[0]);
let uid = pl.data('user_id');
let poid = pl.data('post_id');

function addLikes(uuid, pid){ 
   likes += 1;
   bb.toggleClass('btn btn-danger btn-xs');
   if(bb.value() == "liked") { bb.text("like"); }
   bb.text("liked");
   bb.next().text(likes);
}

bb.click(addLikes);
