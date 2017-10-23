// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

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

submit.on('click', function(){
   console.log("this post should post!");
   channel.push("new_msg", {username: puser.value, title: ntitle.value, body: nbody.value});
   nbody.value = '';
   ntitle.value = '';
});

//channel on(s)
let postList = $("#posts");
let buttons = $(".btns");

const building = ({username, title, body}) => {
   let prow = document.createElement("div");
   prow.className("row");

   let pcard = document.createElement("div");
   pcard.className("card border-secondary mb-3");
   pcard.style.cssText = "margin: 0 auto; width: 40rem;";

   let pheader = document.createElement("div");
   pheader.className("card-header");

   let hcontainer = document.createElement("div");
   hcontainer.className("col-md-12");
   hcontainer.style.cssText = "margin: 0;";
   hcontainer.appendChild(username);
   hcontainer.appendChild(buttons);
  
   pheader.appendChild(hcontainer);
 
   let pcbody = document.createElement("div");
   pcbody.className("card-body")
   
   let pctitle = document.createElement("h4");
   pctitle.className("card-title");
   pctitle.appendChild(title);
   
   let ptcbody = document.createElement("p");
   ptcbody.className("card-body");
   ptcbody.appendChild(body);
   
   pcbody.appendChild(pctitle);
   pcbody.appendChild(ptcbody);
   
   pcard.appendChild(pheader);
   pcard.appendChild(pcbody);

   prow.append(pcard);
   return prow;
};

channel.on("new_msg", payload => {
  let builtPost = building(payload)
  postList.prepend(builtPost)
});


channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
