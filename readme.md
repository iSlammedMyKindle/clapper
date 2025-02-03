# Clapper

Clapper animation for when there needs to be context for something on stream!

Can be recorded through OBS to be a dedicated video, or deployed as a web module. When deployed in that fashion, it can connect to [TLC](https://github.com/iSlammedMyKindle/twitchListenerCore) and pick up when the stream redeems the clapper.

Has a 1 in 5 chance of blowing up

# Usage

Press `Spacebar` to trigger the animation, press `Esc` to cancel!

# Web configuration

1. Export to web through the `/out/pages` directory, name the out file `index.html`
1. self-sign a certificate (see `/out/sslCertificate`)
1. cd into the `out` folder and run `node webServer.mjs`
1. navigate to `localhost:9012` (port will probably change)
1. To connect with TLC, add the following to the url: `?ip=my.linktotlc.blah&reward="name of the redeem here"` (It will run automatically when that redeem is obtained)
1. Use the web browser module on OBS to integrate a hands-free version!

# That's it!

Enjoy! Works on all platforms because godot is awesome like that.