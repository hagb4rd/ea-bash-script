var fs=require("node:fs/promises")
var es=require("event-stream")
var cp=require("child_process")
var path=require("path")
var vm=require("vm")
var net=require("net")
var qs=require("querystring")
var stream=require("stream")
var getArgs=()=>process.argv.slice(2)
var unidecode=require("unidecode")

var f=s=>{ 
  var u=require("unidecode"); 
  var p=String(s).split("/"); 
  var f=p.splice(-1)[0].split(".");  
  var path=p.length>1?p.join("/")+"/":""; 
  var ext=`.${f.length>1?f.splice(-1)[0]:""}`.toLowerCase(); 
  var basename=u(f.join(".")).replaceAll(/[^a-zA-Z0-9\.]+/g, "-").replace(/^[-]+/,"").replace(/[-]+$/,"").toLowerCase(); 
  return `${path}${basename}${ext} ${s}`; 
};


var createContext = exports.createContext = () => {
  return ({ 
      require: require
      ,r: require
      ,p:(resolve,reject)=>new Promise(resolve,reject)
      ,fs:require("node:fs/promises")
      ,es:require("event-stream")
      ,cp:require("node:child_process")
      ,path:require("node:path")
      ,vm:require("node:vm")
      ,net:require("node:net")
      ,http:require("node:http")
      ,https:require("node:https")
      ,qs:require("node:querystring")
      ,stream:require("node:stream")
      ,url:require("node:util")
      ,$:require("ea-1ibs")
      ,getArgs:()=>process.argv.slice(2)
      ,unidecode:require("unidecode") 
    })
}
var compileFn = exports.compileFn = (s) => {
  var cx = createContext();
  var script=vm.createScript(getArgs().join(' ')||'s=>encodeURI(String(s))');
  var mapFn=script.runInNewContext(cx);
  return mapFn;
}
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