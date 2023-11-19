var fs=require("node:fs/promises")
//var es=require("event-stream")
var cp=require("child_process")
var path=require("path")
var vm=require("vm")
var net=require("net")
var qs=require("querystring")
var stream=require("stream")
var getArgs=()=>process.argv.slice(2)
var unidecode=require("unidecode")
var { Readable, Writeable, Transform, compose } = require("node:stream");


var f=s=>{ 
  var u=require("unidecode"); 
  var p=String(s).split("/"); 
  var f=p.splice(-1)[0].split(".");  
  var path=p.length>1?p.join("/")+"/":""; 
  var ext=`.${f.length>1?f.splice(-1)[0]:""}`.toLowerCase(); 
  var basename=u(f.join(".")).replaceAll(/[^a-zA-Z0-9\.]+/g, "-").replace(/^[-]+/,"").replace(/[-]+$/,"").toLowerCase(); 
  return `${path}${basename}${ext} ${s}`; 
  var fileInfo = {
    dir:path,
    basename:basename,
    ext:ext
  }
  return fileInfo;
};


var createContext = exports.createContext = () => {
  return ({ 
      require: require
      ,r: require
      ,f: f
      ,fs:require("node:fs/promises")
      ,es:require("node:stream")
      ,cp:require("node:child_process")
      ,path:require("node:path")
      ,vm:require("node:vm")
      ,net:require("node:net")
      ,http:require("node:http")
      ,https:require("node:https")
      ,qs:require("node:querystring")
      ,stream:require("node:stream")
      ,util:require("node:util")
      //,$:require("ea-1ibs")
      ,getArgs:()=>process.argv.slice(2)
      ,unidecode:require("unidecode") 
    })
}
var compile = exports.compile = (s) => {
  var cx = createContext();
  var script=vm.createScript(s||'s=>encodeURI(String(s))');
  var mapFn=script.runInNewContext(cx);
  return mapFn;
}
/*
var mapStream = exports.mapStream = (fn) => { 
    var    count=0;
    return es.pipe(
        es.split(),
        es.map((data,cb)=>cb(null,(count++>0?"\n":"")+fn(data)))
     );
} 


var filter = exports.filter = function(fn) { 
  return es.pipe(
    es.split(),
    es.map((data,cb)=>fn(data)?cb(null,data+"\n"):cb(null))
  ); 
};
/* */

var readLine = exports.readLine = async function*(source) {
	var rest="";
  for await (var chunk of source) {
   var lines = String(chunk).split(/\r?\n/);
   lines[0]=rest+lines[0];
   rest=lines.pop()
   for (var line of lines) {
    yield line;
   }
  }
}

var splt=exports.splt=(stream)=>{ 
	var next,buffer; 
	var stream=new require("node:stream").Transform({
  transform(chunk, encoding, callback) {
  	callback(null, chunk)
    // ...
  }
});
	stream.on("readable", ()=>{
		while(null !== (next=stream.read(1))) {		
			if(next.toString()=="\n") {
					stream.write(buffer+"\n");
					buffer="";
			} else {
				buffer += next.toString();
			}
		}

	})
	return stream;
}

var split = exports.split = (expression) => async function*(source) {
  expression=expression||'\r?\n'
  var regex=new RegExp(expression);
  for await (var chunk of source) {
   var lines = String(chunk).split(regex);
   for (var line of lines) {
    yield line;
   }
  }
}

var join = exports.join = (delim="\n") => async function*(source) {
  var delimiter=""
  for await (var chunk of source) {
    yield delimiter+chunk;
    delimiter=delim
  }
}


var splitLine = exports.splitLine = async function*(source) {
  var delimiter=""
  for await (var chunk of source) {
    yield delimiter+chunk;
    delimiter="\n"
  }
}


var mapStream = exports.mapStream = (fn) => { 
    var    count=0;
    return compose(readLine, new Transform({
      transform(data, endcoding, cb) { 
        cb(null,(count++>0?"\n":"")+fn(String(data)));
      }
    }));
}

var readLines = exports.readLines = async(s) => { 
  s=s||process.openStdin();
  return JSON.stringify(await (Readable.from(s).compose(readLine).toArray()));
}


var inline = exports.inline = (fn) => { 
    var    count=0;
   fn=fn||(s=>`'${String(s).replace(/'/g,"\'")}'`);
    return compose(readLine, new Transform({
      transform(data, endcoding, cb) { 
        cb(null,(count++>0?",":"")+fn(String(data)));
      }
    }));
}
 
/*
process.openStdin()
  .pipe(mapStream(s=>s.toUpperCase()))
  .pipe(process.stdout);
/* */
