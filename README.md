# quick_public_web_server
Serves a folder locally and exposes it via Cloudflare’s try-tunnel for short-lived testing.

```bash
./fast_public_server.sh /path/to/folder <port>
```
Default path is pwd and default port is 8156.

Just made this script in the context of a RootMe challenge. This no use for permanent exposure.

If needed to install cloudflared ``https://pkg.cloudflare.com/index.html``
