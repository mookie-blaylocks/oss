%% second(X,[_,X|_]).
%% swap12([X,Y|Z],[Y,X|Z]).

%% tran(eins,one).
%% tran(zwei,two).
%% tran(drei,three).
%% tran(vier,four).
%% tran(fuenf,five).
%% tran(sechs,six).
%% tran(sieben,seven).
%% tran(acht,eight).
%% tran(neun,nine).

%% listtran([],[]).
%% listtran([G|GT],[E|ET]):-
%%     tran(G,E),
%%     listtran(GT,ET).

%% twice([],[]).
%% twice([H1|T1],[H1,H1|T2]):-
%%     twice(T1,T2).

%% combineA([],[],[]).
%% combineA([H1|T1],[H2|T2],[H1,H2|T3]):-
%%     combine1(T1,T2,T3).

%% combine([],[],[]).
%% combine([H1|T1],[H2|T2],[[H1,H2]|T3]):-
%%     combine(T1,T2,T3).

j(X,Y).
combine([],[],[]).
combine([H1|T1],[H2|T2],[j(H1,H2)|T3]):-
    combine(T1,T2,T3). 
