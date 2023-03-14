var https=require("node:https")

var resolveUri=(shortUri)=>new Promise((resolve,reject)=>{ 
	var req=https.request(shortUri, { method: 'head' }, resp=>resolve(resp.headers.location)); 
	req.on('error', (err)=>{
		console.log('error resolving short uri:', err);
		resolve(shortUri);  
	})
	req.end(); 
})


var replaceShortUrls=exports.replaceShortUrls=async(msg)=>{
	var rx=/https\:\/\/t.co\/\w+/; 
	var shortUris=msg.match(rx);

	if(shortUris && shortUris.length) {
		var resolvedUris=await Promise.all(shortUris.map(shortUri=>resolveUri(shortUri)));
		/*
		shortUris.forEach((shortUri,index)=>{
			msg=msg.replace(shortUri, resolvedUris[index]);
		})
		/* */
		return Object.entries(shortUris)
			.reduce((newMessage,[index,shortUri])=>resolvedUris[index] 
				? newMessage.replace(shortUri, resolvedUris[index]) 
				: newMessage
			, msg)
		//var resolvedUri=await resolveUri(shortUri); 
		//return msg.replace(rx, ()=>resolvedUri); 
		//return msg;
	} else {
		return msg;	
	};  
	
}; 

var needle = exports.needle = (url, params, options) => new Promise((resolve,reject)=> {
		var buffer;
		var searchURI=new URL(url);
		var tweetURI=Object.entries(params).reduce((uri,[k,v])=>(uri.searchParams.set(k,v),uri), searchURI)
		
		var opts = {
    		method: "get",
        headers: {
            "Authorization": `Bearer ${token}`
            //,"Content-Type": "application/json"
            //,"Content-Length": Buffer.byteLength(body)
        },
    }
    if (options && options.headers) 
    	Object.assign(opts.headers, options.headers);
    	
    if(options.method)
    	opts.method=method;
		
    var req = https.request(tweetURI, opts, (resp)=>{
    	resp.on('data',(data)=>{    		
    		//console.log(data)
    		if(!buffer) {
 					buffer=data;   		
    		} else {
	    		buffer=Buffer.concat([buffer,data]);    			
    		}
    	})
     	resp.on('end',(data)=>{
    		if(!buffer) {
 					buffer=data
    		} else {
    			if(data) {
    				buffer=Buffer.concat([buffer,data]);    			
    			}
    		}
    		//var msg=buffer.toString("utf8");
    		var msg=JSON.parse(buffer);
    		resolve(msg)    
    	})
		});
})



