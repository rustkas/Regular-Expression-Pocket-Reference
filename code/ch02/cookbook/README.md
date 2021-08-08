cookbook
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new lib introduction && cd introduction
	
## Get dependencies
	$ rebar3 deps	

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m cookbook_tests
	$ rebar3 eunit -m numbers_tests
	$ rebar3 eunit -m valid_html_hex_code_tests

PropEr test
-----
    $ rebar3 proper


PropEr test (make 10_000 tests)
-----	
	$ rebar3 proper -n 10000	