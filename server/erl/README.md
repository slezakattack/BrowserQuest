BrowserQuest Erlang Server Documentation
========================================

Overview
--------

A personal experiment to replace BrowserQuest nodejs back-end with Erlang powered by Yaws. 
When finished, will like to try to run benchmark tests to see how both perform.

Dependencies
------------

This is not final but the intended dependencies are:
- Erlang R15B01
- Yaws ver 1.92
- rebar
- more to come as the project takes shape...

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
