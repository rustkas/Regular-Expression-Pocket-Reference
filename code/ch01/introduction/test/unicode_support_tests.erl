% For research For research mode, activate the RESEARCH constant.
%
-module(unicode_support_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

-ifdef(RESEARCH).

reasearch_test() ->
    Text = "\n",
    Regex = "\\012",
    TunedRegex = re_tuner:replace(Regex),
    {match, Result} = re:run(Text, get_mp(TunedRegex), [{capture, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

unicode_01_test() ->
    Expected = "è",
    Text = " è",
    Regex = "\\w",
    
{match, [Result]} = re:run(Text, get_mp(Regex,[unicode,ucp]), [{capture, first, list}]),
    ?assertEqual(Expected, Result).

unicode_02_test() ->
    Expected = "e",
    Text = "e",
    Regex = "\\w",
    
{match, [Result]} = re:run(Text, get_mp(Regex,[unicode,ucp]), [{capture, first, list}]),
    ?assertEqual(Expected, Result).
-endif.
-endif.
