increment(X,Y) :- Y is X+1.
sum(X,Y,Z) :- Z is X+Y.
addone([],[]).
addone([H1|T1],[H2|T2]) :-
    H2 is H1+1,
    addone(T1,T2).

accMax([H|T],A,Max) :-
    H > A,
    accMax(T,H,Max).
accMax([H|T],A,Max) :-
    H =< A,
    accMax(T,A,Max).
accMax([],A,A).

accMin([H|T],A,Min) :-
    H < A,
    accMin(T,H,Min).
accMin([H|T],A,Min) :-
    H >= A,
    accMin(T,A,Min).
accMin([],A,A).

scalarMult(_,[],[]).
scalarMult(X,[H1|T1],[H2|T2]) :-
    H2 is H1*X,
    scalarMult(X,T1,T2).

accLen([_|T],A,L) :-
    Anew is A+1,
    accLen(T,Anew,L).
accLen([],A,A).

accDot([H1|T1],[H2|T2],A,L) :- 
    Anew is A+(H1*H2),
    accDot(T1,T2,Anew,L).
accDot([],[],A,A).
dot(L1,L2,X) :- accDot(L1,L2,0,X).

    
    
