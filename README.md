PHP 8.1-Apache 2.4.x and CodeIgniter 4
This include http (80) and https (443) with SSL localhost that i have generate my mkcert. Just install mkcert from this fork repo: https://github.com/ibrahimzfe/mkcert.git
And running: 
```
$ mkcert -install
Created a new local CA 💥
The local CA is now installed in the system trust store! ⚡️
The local CA is now installed in the Firefox trust store (requires browser restart)! 🦊
$ mkcert localhost 127.0.0.1 ::1
```


If you have domain SSL. Just replace the file and adjust the code.
