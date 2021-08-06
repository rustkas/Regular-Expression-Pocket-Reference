% For research For research mode, activate the RESEARCH constant.
%
-module(cookbook_tests).

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

% \n
lf_test() ->
    Expected = "\n",
    Text = Expected,
    Regex = "(?:\\012|\\015)",
    {match, [Result]} = re:run(Text, get_mp(Regex), [{capture, first, list}]),

    ?assertEqual(Expected, Result).

ents() ->
    Expected = "perl, Perl, PeRl",
    Text = "perl, Perl, PeRl",
    Regex = ".{0,80} #Field limit is 80 chars",
    {match, Result} =
        re:run(Text, get_mp(Regex, [extended]), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
