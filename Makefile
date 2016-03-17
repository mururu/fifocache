.PHONY: all compile clean xref eunit dialyzer

all: compile eunit xref dialyzer

compile:
	@./rebar3 compile

clean:
	@./rebar3 clean

eunit:
	@./rebar3 eunit

dialyze:
	@./rebar3 dialyzer
