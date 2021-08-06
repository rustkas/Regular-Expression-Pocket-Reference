introduction
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
	$ rebar3 eunit -m character_representations_tests
	$ rebar3 eunit -m grouping_tests
	$ rebar3 eunit -m unicode_support_tests