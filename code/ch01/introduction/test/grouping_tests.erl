% For research For research mode, activate the RESEARCH constant.
%
-module(grouping_tests).

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

duplicate_words_test() ->
    Expected = "the",
    Text = "the the",
    Regex = "\\b(\\w+)\\b\\s+\\1\\b",

    TunedRegex = re_tuner:replace(Regex),
    Result = re:replace(Text, TunedRegex, "\\1", [{return, list}]),

    ?assertEqual(Expected, Result).

grouping_only_test() ->
    Expected = "foobar",
    Text = "foobar",
    Regex = "(?:foobar)",
    {match, [Result]} = re:run(Text, get_mp(Regex), [{capture, all, list}]),
    ?assertEqual(Expected, Result).

named_capture_test() ->
    Expected = "foobar",
    Text = "Subject:foobar",
    Regex = "Subject:(?<subject>.*)",
    {match, [Result]} = re:run(Text, get_mp(Regex), [{capture, [subject], list}]),

    ?assertEqual(Expected, Result).

atomic_grouping_01_test() ->
    Expected = "aabbcc",
    Text = "aabbcc",
    Regex = "(?>[ab]*)\\w\\w",

    {match, [Result]} = re:run(Text, get_mp(Regex), [{capture, all, list}]),

    ?assertEqual(Expected, Result).

atomic_grouping_02_test() ->
    Expected = nomatch,
    Text = "aabbaa",
    Regex = "(?>[ab]*)\\w\\w",

    Result = re:run(Text, get_mp(Regex), [{capture, all, list}]),

    ?assertEqual(Expected, Result).

alternation_test() ->
    Expected = [["foo"], ["bar"]],
    Text = "foo bar",
    Regex = "\\b(foo|bar)\\b",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

conditional_test() ->
    Expected = [["<foo>"], ["foobar"]],
    Text = "<foo> foobar",
    Regex = "(<)?foo(?(1)>|bar)",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

greedy_quantifiers_test()->
    Expected = [["ababababab"]],
    Text = "ababababab",
    Regex = "(ab)+",
    {match, Result} = re:run(Text, get_mp(Regex), [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

lazy_quantifiers_test()->
    Expected = ["an"],
    Text = " banana",
    Regex = "(an)+?",
    {match, Result} = re:run(Text, get_mp(Regex), [{capture, first, list}]),
    ?assertEqual(Expected, Result).
	
possessive_quantifiers_test()->
    Expected = nomatch,
    Text = "ababababab",
    Regex = "(ab)++ab",
    Result = re:run(Text, get_mp(Regex), [{capture, first, list}]),
    ?assertEqual(Expected, Result).


-endif.
-endif.
