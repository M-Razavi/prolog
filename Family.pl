/* family */
male(michel).
male(charles_gordon).
male(charls).
male(jim).
male(elmi).
male(greq).
female(melody).
female(hazel).
female(elenor).
female(crystal).
father(michel,cathy).
father(charles_gordon,michel).
father(charles_gordon,juile).
father(charls,charles_gordon).
father(jim,melody).
father(jim,crystal).
father(elmi,jim).
father(greq,stephanie).
mother(melody,cathy).
mother(hazel,michel).
mother(hazel,julie).
mother(elenor,melody).
mother(hazel,crystal).
mother(crystal,stephanie).

parent(X,Y):-father(X,Y).
parent(X,Y):-mother(X,Y).
parnet(X,Y):-father(X,Y);mother(X,Y).

grandfather(GF,GC):-father(F,GC),father(GF,F).
grandfather(GF,GC):-mother(M,GC),father(GF,M).
grandmother(GM,GC):-father(F,GC),mother(GM,F).
grandmother(GM,GC):-mother(M,GC),mother(GM,M).

is_a_grandmother(X):-mother(X,Y),parent(Y,Z).
is_a_grandmother(X):-mother(X,Y),parent(Y,_).

sibling(X,Y):-mother(M,X),mother(M,Y),X\==Y.
aunt(A,C):-parent(P,C),sibling(A,P),female(A).
uncle(U,C):-parent(P,C),sibling(U,P),male(U).



