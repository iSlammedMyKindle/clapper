/* Made by iSlammedMyKindle in 2023!
    A clone of a clone of an I have no idea at this point beacuse this should be a module instead of something I copy across projects!
    Modified from tGem to include headers that the godot build needs in order to function
    Fixed a bug with url detection - search parameters were being picked up when they shouldn't have
*/
import http from "http";
import fs from "fs/promises";

const mimeTypes = {
    'html': "text/html",
    "js": "text/javascript",
    "mjs": "text/javascript",
    "css": "text/css",
    "svg": "image/svg+xml",
    "png": "image/png",
    "mp3": "audio/mpeg",
    "wav": "audio/wav"
}

// Gonna be pretty simple; obtain the file just by reading the file name. If it doesn't exist, 404
const webServer = http.createServer(async (req, res)=>{
    // the url isn't a reliable source for grabbing the specific name when it comes to javaScript, so we're grabbing it from the header
    // Doesn't seem like we can guarantee it, so let's grab it if we can
    const urlSource = req.headers.referer || req.url;
    var path = urlSource.substring(urlSource.lastIndexOf("/"));
    var fileName = new URL('https://example.com'+req.url).pathname;
    
    // There was originally code here that would block ".." in the url, but it turns out `GET` commands in general sort themselves out and can't go past a certain point. So there's no point in blocking this if the server automatically has protection
    if(!fileName.includes('.')) fileName ="/index.html";

    const extension = fileName.substring(fileName.lastIndexOf(".")+1);
    var resBuff;

    try{
        resBuff = await fs.readFile("pages"+path+fileName);
    }
    catch(e){
        // Run another try/catch to try to obtain the item within the root of the pages path
        try{
            resBuff = await fs.readFile("pages"+fileName);   
        }
        catch(e){
            write404(res);
            return;
        }
    }

    res.setHeader("Content-type", mimeTypes[extension] || "application/octet-stream");
    res.setHeader("Cross-Origin-Opener-Policy", "same-origin");
    res.setHeader("Cross-Origin-Embedder-Policy", "require-corp");
    res.setHeader("Access-Control-Allow-Origin", "*");

    res.statusCode = 200;
    res.write(resBuff);
    res.end();

});

function write404(res){
    res.statusCode = 404;
    res.write('404 - Not found');
    res.end();
}

webServer.listen(9012);
console.log("Webserver has been started");