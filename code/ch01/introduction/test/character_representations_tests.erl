% For research For research mode, activate the RESEARCH constant.
%
-module(character_representations_tests).

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

crlf_test() ->
    Expected = "\r\n",
    Text = "\r\n",
    Regex = "\\015(?:\\012|\\015)",
    {match, [Result]} = re:run(Text, get_mp(Regex), [{capture, first, list}]),

    ?assertEqual(Expected, Result).

crlf2_test() ->
    Expected = "\r\n",
    Text = "\r\n",
    Regex = "\\x0D(?:\\x0A|\\x0D)",
    {match, [Result]} = re:run(Text, get_mp(Regex), [{capture, first, list}]),

    ?assertEqual(Expected, Result).

unicode_test() ->
    Expected = ["α"],
    Text = "α",
    Regex = "\\p{Ll}",
    {match, [Result]} =
        re:run(Text, get_mp(Regex, [unicode]), [global, {capture, first, list}]),

    ?assertEqual(Expected, Result).

% Ignore case
ignore_case_test() ->
    Expected = [["perl"], ["Perl"], ["PeRl"]],
    Text = "perl, Perl, PeRl",
    Regex = "(?i)perl",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

% Comment
comments() ->
    Expected = "perl, Perl, PeRl",
    Text = "perl, Perl, PeRl",
    Regex = ".{0,80} #Field limit is 80 chars",
    {match, Result} =
        re:run(Text, get_mp(Regex, [extended]), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
