REBAR := ./bin/rebar3

.PHONY: compile
compile:
	$(REBAR) do compile, dialyzer

.PHONY: test
test:
	$(REBAR) as test do compile, ct, cover

.PHONY: clean
clean:
	$(REBAR) clean --all
	@rm -rf _build/

