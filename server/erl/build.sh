#!/bin/bash
echo "Compiling Erlang source files..."
./rebar -v compile
echo "Running unit tests..."
./rebar -v eunit
