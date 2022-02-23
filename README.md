# Audio Room

Docker container to serve a quick and simple completely self-contained WebRTC audio conferencing room, no other connections necessary. [Janus Gateway](https://github.com/meetecho/janus-gateway) is used as a WebRTC server, nginx serves the web page, and [Coturn](https://github.com/coturn/coturn) is used as a STUN server. 

# History

First all glued together by [Ammar](https://github.com/0x41mmarVM)

## Usage

Build the docker container and run

```bash
$ docker build . -t audioroom
$ docker run --rm --detach --name audioroom -p 80:80 -p 3478:3478/udp -p 10000-10200:10000-10200/udp audioroom
```

## UDP and Port Forwarding

* *80/tcp* : Web server
* *3478/udp* : STUN server, for NAT traversal
* *10000-10200/udp* : RTP communication port range

Though the signalling mechanism runs on the standard http interface, WebRTC still uses udp for actual data transfer. The server is configured to choose ports in the range 10000-10200, which must be exposed for audio to work.

Additionally, since this is UDP, a STUN server is required for successful NAT-traversal, but this doesn't have to run on the same server, as its function is essentially for clients to discover their public IP. The client (JS) has been configured to assume a STUN server is available on the same hostname the page is being served from, at port 3478/udp. If the common solution of using Google's public STUN (stun.l.google.com), the hostname needs to be modified in janus.js
