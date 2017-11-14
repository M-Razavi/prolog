% File GETYESNO.PL 
% Menu that obtains 'yes' or 'no' answer

get_yes_or_no(Result) :- 	get(Char),	% read a character 
						%get(A),			% consume the Return after it interpret(Char,Result), 
						!.				% cut -- see text
get_yes_or_no(Result) :- 	nl, 
						put(7),			% beep 
						write('Type Y or N:'), 
						get_yes_or_no(Result).
interpret(89,yes).						% ASCII 89 = 'Y' 
interpret(121,yes).					% ASCII 121 = 'y' 
interpret(78,no).						% ASCII 78 = 'N' 
interpret(110,no).						% ASCII 110 = 'n'