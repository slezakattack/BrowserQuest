BrowserQuest Erlang Server Documentation
========================================

A personal experiment to replace BrowserQuest nodejs back-end with Erlang powered by Yaws. 
When finished, will like to try to run benchmark tests to see how both perform.

Dependencies
------------

This is not final but the intended dependencies are:
- Erlang R15B01
- Yaws ver 1.92
- rebar
- more to come as the project takes shape...

Installing Yaws 1.92
--------------------

If `sudo apt-get install yaws` only puts you at an earlier version than 1.92, then you will have to manually install yaws.
First, choose a directory to download yaws. I chose `~/Downloads`. Then, run these commands:
`wget yaws.hyber.org/download/yaws-1.92.tar.gz`

`cd` into the directory in which you downloaded yaws. Now run,
`tar zxf yaws-1.92.tar.gz`
Yaws depends on libpam so install that package using `sudo apt-get install libpam0g-dev`.
Now `cd` into your yaws directory. Not the yaws-1.92 directory..
Run `./configure --prefix=/usr/local`
`make`
`make local_install` since we are developing locally on yaws.
There should be a bin directory in your home directory. Simply run `./bin/yaws --version` and hopefully you are on 1.92!
To run yaws in interactive mode, run `./bin/yaws -i` and a server will start on 0.0.0.0:8000. For yaws configuration, refer to
the documentation at http://yaws.hyber.org.

Configuration
-------------

If you know a bit of Erlang, configuration should be simple and lives in `include/config_local.hrl` which mirrors `config_local.json`.
Perhaps in the near future, this project will use the original `config_local.json` file.

Build
-----

Simply run the `build.sh` script. This will compile the project and run unit tests.

Deployment
----------

Coming soon.

Monitoring
----------

Coming soon.
