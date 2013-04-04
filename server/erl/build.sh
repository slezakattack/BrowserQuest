#!/bin/bash
echo "Compiling Erlang source files..."
./rebar compile
echo "Running unit tests..."
./rebar eunit
