
[![Build Status](https://travis-ci.org/cyber-dojo/runner.svg?branch=master)](https://travis-ci.org/cyber-dojo/runner)

<img src="https://raw.githubusercontent.com/cyber-dojo/nginx/master/images/home_page_logo.png" alt="cyber-dojo yin/yang logo" width="50px" height="50px"/>

# **cyberdojo/runner** docker image

A cyberdojo/runner docker-container runs sinatra on port 4557.

## API

### pulled?(image_name)
- parameters
  * image_name, eg 'cyberdojofoundation/gcc_assert'
- returns
  * { "status":"true" , "output":unspecified } -> pulled already
  * { "status":"false", "output":unspecified } -> not pulled already

### pull(image_name)
- parameters
  * image_name, eg 'cyberdojofoundation/gcc_assert'
- returns
  * { "status":"ok", "output":unspecified } -> pull succeeded

### hello(kata_id, avatar_name)
- parameters
  * kata_id, eg '15B9AD6C42'
  * avatar_name, eg 'salmon'
- returns
  * { "status":"ok", "output":unspecified } -> succeeded

### goodbye(kata_id, avatar_name)
- parameters
  * kata_id, eg '15B9AD6C42'
  * avatar_name, eg 'salmon'
- returns
  * { "status":"ok", "output":unspecified } -> succeeded

### run(image_name, kata_id, avatar_name, max_seconds, deleted_filenames, changed_files)
- parameters
  * image_name, eg 'cyberdojofoundation/gcc_assert'
  * kata_id, eg '15B9AD6C42'
  * avatar_name, eg 'salmon'
  * max_seconds, eg '10'
  * deleted_filenames, eg [ filename, ... ]
  * changed_files, eg { filename => content, ... }
- returns
  * { "status":"0",   "output":output } -> succeeded
  * { "status":"137", "output":"" } -> did not complete in max_seconds

- if something unexpected goes wrong on the server all methods return
  * { status:error, output:msg } -> something went wrong

## rebuild the runner-client and runner-server images
```
$ ./build.sh
```

## bring up a runner-client and runner-server container

```
$ ./up.sh
```

## run the runner-server's tests inside a runner-server container
```
$ ./test.sh
```

## run a runner-client demo
```
$ ./demo.sh
```
Runs inside the runner-client container.
Calls each of the runner-server's micro-service methods
once and displays their json results.
If the runner-client's IP address is 192.168.99.100 then put
192.168.99.100:4558 into your browser to see the output.

