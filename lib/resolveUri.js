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





