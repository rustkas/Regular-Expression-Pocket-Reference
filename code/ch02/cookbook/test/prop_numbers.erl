-module(prop_numbers).

-include_lib("proper/include/proper.hrl").

-include("helper.util").

%%%%%%%%%%%%%%%%%%
%%% Properties %%%
%%%%%%%%%%%%%%%%%%
prop_numbers() ->
    ?FORALL(Integer,
            range(1, 999999),
            begin
                Text = sstr:integer_to_list(Integer),
                Result = re:run(Text, get_mp("^\\d{1,6}$"), [{capture, first, list}]),
                {match, [Text]} == Result
            end).
