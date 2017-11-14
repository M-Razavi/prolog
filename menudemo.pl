capitalof(georgia,atlanta).
capitalof(california,sacramento).
capitalof(florida,tallahassee).
capitalof(maine,augusta).

% Procedures to interact with user
start:-	
	displaymenu, 
	getfrommenu(State), 
	capitalof(State,City), nl,
	write('The capital of '),
	write(State), write(' is '), 
	write(City), nl.
displaymenu:-
	write('Which state do you want to know about?'),nl,
	write(' 1 Georgia'),nl,
	write(' 2 California'),nl,
	write(' 3 Florida'),nl,
	write(' 4 Maine'),nl,
	write('Type a number, 1 to 4 -- ').
getfrommenu(State) :-  
	get(Code), % read a character 
	%get_byte(), % consume the Return keystroke 
	interpret(Code,State).
	interpret(49,georgia).
	interpret(50,california).
	interpret(51,florida).
	interpret(52,maine).
:-start.

/* ASCII 49 = '1' */ 
/* ASCII 50 = '2' */ 
/* ASCII 51 = '3' */ 