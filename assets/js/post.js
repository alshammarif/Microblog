import "phoenix_html"

import socket from  "./socket"

//connect to socket
socket.connect();

//create channel 
let channel = socket.channel("updates:all",{});

let postsContainer = document.querySelector("#posts")

const pullPost = ({username, title, body}) => {
let shell = document.createElement('div')
shell.className = "row"

let pContain = document.createElement('div')
pContain.className = "card border-secondary mb-3"

let pHeader = document.createElement('div')
pHeader.className = "card-header"

let innerH = document.createElement('div')
innerH.className = "col-md-12"
innerH.innerText = username

pHeader.appendChild(innerH)
pHeader.appendChild('btns')

let poBody = document.createElement('div')
poBody.className = "card-body"

let h4Title = document.createElement('h4')
h4Title.className = "card-title"
h4Title.innerText = title

let pBody = document.createElement('p')
pBody.className = "card-text"
pBody.innerText = body

poBody.appendChild(h4Title)
poBody.appendChild(pBody)

pContain.appendChild(pHeader)
pContain.appendChild(poBody)

shell.appendChild(pContain)
return shell;
}

channel.on("new_msg", payload => {
console.log("added posts", payload)

if(postContainer) {
let newPost = pullPost(payload)
postsContainer.prepend(newPost)
}
})
