% It is long running test.
%
% Numbers from 0 to 999999
% ^\\d{1,6}$
%
% Matches: 42, 678234
% Nonmatches: 1000000
% For research For research mode, activate the RESEARCH constant.
%
-module(numbers_tests).

%%
%% Tests
%%
-ifdef(TEST).

get_Text(N) ->
    sstr:integer_to_list(N).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
-include("helper.util").

numbers_test_0() ->
    {timeout, 480, [{"Check 999999 values by regex", fun numbers/0}]}.

numbers() ->
    % Numbers from 0 to 999999
    MP = get_mp("^\\d{1,6}$"),
    Options = [{capture, first, list}],
    numbers(999999, MP, Options).

numbers(N, MP, Options) when N > 0 ->
    Text = get_Text(N),
    %?debugFmt("Test countdown = ~p~n", [Text]),
    ?assert({match, [Text]} == re:run(Text, MP, Options)),
    numbers(N - 1, MP, Options).

big_number_test() ->
    Value = 1000000,
    Text = get_Text(Value),
    MP = get_mp("^\\d{1,6}$"),
    Options = [{capture, first, list}],
    ?assertEqual(nomatch, re:run(Text, MP, Options)).

-endif.
