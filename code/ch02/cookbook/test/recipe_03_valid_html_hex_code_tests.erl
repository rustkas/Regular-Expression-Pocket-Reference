% It is long running test.
%
% Valid HTML Hex code
% ^#([a-fA-F0-9]){3}(([a-fA-F0-9]){3})?$
%
% Matches: #fff, #1a1, #996633
% Nonmatches: #ff, FFFFFF
%
% For research For research mode, activate the RESEARCH constant.
%
-module(recipe_02_valid_html_hex_code_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Add commond helper files to the module
%-include("helper.util").

print(_Text) ->
    %?debugFmt("~p~n", [_Text]),
    ok.

html_hex_test() ->
    % Valid HTML Hex code
    {ok, MP} = re:compile("^#([a-fA-F0-9]){3}(([a-fA-F0-9]){3})?$"),
    Options = [{capture, first, list}],
    numbers({[0, 0, 0], [0, 0, 0]}, MP, Options).

numbers({[R1, G1, B1], [R2, G2, B2]}, MP, Options) when B1 < 16#F ->
    HexString = sstr:hex([R1, G1, B1]),
    {match, [Text]} = re:run(HexString, MP, Options),
    print(Text),
    numbers({[R1, G1, B1 + 1], [R2, G2, B2]}, MP, Options);
numbers({[R1, G1, B1], [R2, G2, B2]}, MP, Options) when G1 < 16#F ->
    HexString = sstr:hex([R1, G1, B1]),
    {match, [Text]} = re:run(HexString, MP, Options),
    print(Text),
    numbers({[R1, G1 + 1, B1], [R2, G2, B2]}, MP, Options);
numbers({[R1, G1, B1], [R2, G2, B2]}, MP, Options) when R1 < 16#F ->
    HexString = sstr:hex([R1, G1, B1]),
    {match, [Text]} = re:run(HexString, MP, Options),
    print(Text),
    numbers({[R1 + 1, G1, B1], [R2, G2, B2]}, MP, Options);
numbers({[R1, G1, B1], [R2, G2, B2]}, MP, Options) when B2 < 16#F ->
    HexString = sstr:hex([R1, G1, B1, R2, G2, B2]),
    {match, [Text]} = re:run(HexString, MP, Options),
    print(Text),
    numbers({[R1, G1, B1], [R2, G2, B2 + 1]}, MP, Options);
numbers({[R1, G1, B1], [R2, G2, B2]}, MP, Options) when G2 < 16#F ->
    HexString = sstr:hex([R1, G1, B1, R2, G2, B2]),
    {match, [Text]} = re:run(HexString, MP, Options),
    print(Text),
    numbers({[R1, G1, B1], [R1, G2 + 1, B2]}, MP, Options);
numbers({[R1, G1, B1], [R2, G2, B2]}, MP, Options) when R2 < 16#F ->
    HexString = sstr:hex([R1, G1, B1, R2, G2, B2]),
    {match, [Text]} = re:run(HexString, MP, Options),
    print(Text),
    numbers({[R1, G1, B1], [R1, G2, B2 + 1]}, MP, Options);
numbers({[R1, G1, B1], [R2, G2, B2]}, MP, Options) ->
    HexString = sstr:hex([R1, G1, B1, R2, G2, B2]),
    {match, [Text]} = re:run(HexString, MP, Options),
    print(Text).

-endif.
