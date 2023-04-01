#!/usr/bin/env node
var hljs=require("highlight.js");
var hh=(s)=>hljs.highlightAuto(s)

var buffer="";


var stdin=process.openStdin();
stdin.setEncoding('utf-8');
stdin.on("data", (data)=>{
	buffer += data;
})
stdin.on("end", (data)=>{
	if(data) {
		buffer+=data
	}
	process.stdout.write(hh(buffer));
})
