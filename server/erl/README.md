BrowserQuest Erlang Server Documentation
========================================
A personal experiment to replace BrowserQuest nodejs back-end with Erlang powered by Cowboy.
When finished, will like to try to run benchmark tests to see how both perform.

Dependencies
------------
You will need Erlang 19.3 installed to run the server.

Configuration
-------------
If you know a bit of Erlang, configuration should be simple and lives in `include/config_local.hrl` which mirrors `config_local.json`.
Perhaps in the near future, this project will use the original `config_local.json` file.

Build
-----
Run `make` to compile or `make test` to run automated tests.
