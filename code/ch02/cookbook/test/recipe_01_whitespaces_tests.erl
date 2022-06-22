% For research For research mode, activate the RESEARCH constant.
%
% Removing leading and trailing whitespace
% s/^\s+//
% s/\s+$//
%

-module(recipe_01_whitespaces_tests).

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
    {match, Result} = re:run(Text, get_mp(TunedRegex), [{capture, first, list}]),
    ?debugFmt("Result = ~p~n", [Result]).

-else.

% Removing leading and trailing whitespace
removing_whitespaces_01_test() ->
    Expected = "foo bar",
    Text = " foo bar ",
    Regex = "^\\s+|\\s+$",
    TunedRegex = re_tuner:replace(Regex),
    Replacement = "",
    Result = re:replace(Text, TunedRegex, Replacement, [global, {return, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
