
[![Build Status](https://travis-ci.org/cyber-dojo/runner.svg?branch=master)](https://travis-ci.org/cyber-dojo/runner)

<img src="https://raw.githubusercontent.com/cyber-dojo/nginx/master/images/home_page_logo.png" alt="cyber-dojo yin/yang logo" width="50px" height="50px"/>

Repo for cyberdojo/runner docker image.

Planned API

- If something unexpected goes wrong on the server all methods return
  * { status:error, output:msg }           something went wrong

- pulled?
  * { status:true,  output:unspecified }   pulled already
  * { status:false, output:unspecified }   not pulled already

- pull
  * { status:true,  output:unspecified }   pull succeeded

- hello_avatar
  * { status:true,  output:unspecified }   succeeded

- goodbye_avatar
  * { status:true,  output:unspecified }   succeeded

- run
  * { status:true,   output:output }       succeeded
  * { status:false,  output:'' }           timed-out-and-killed


```
./build.sh
```
Rebuilds the runner-client and runner-server images.

```
./up.sh
```
Brings up the runner-client and runner-server containers.

```
./test.sh
```
Runs the runner-server's tests inside the runner-server container.

```
./demo.sh
```
The runner-client calls each of the runner-server's micro-service methods
once and displays their json results.
If the runner-client's IP address is 192.168.99.100 then put
192.168.99.100:4558 into your browser to see the output.

