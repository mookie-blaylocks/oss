%% directlyIn(irina,natasha).
%% directlyIn(natasha,olga).
%% directlyIn(olga,katarina).

%% in(X,Y) :- directlyIn(X,Y).
%% in(X,Y) :-
%%     directlyIn(X,Z),
%%     in(Z,Y).

%% directTrain(saarbruecken,dudweiler).
%% directTrain(forbach,saarbruecken).
%% directTrain(freyming,forbach).
%% directTrain(stAvold,freyming).
%% directTrain(fahlquemont,stAvold).
%% directTrain(metz,fahlquemont).
%% directTrain(nancy,metz).

%% travelFromTo(X,Y) :- directTrain(X,Y).
%% travelFromTo(X,Y) :-
%%     directTrain(X,Z),
%%     travelFromTo(Z,Y).

%% numeral(0).
%% numeral(succ(X)) :- numeral(X).

%% add(0,Y,Y).
%% add(succ(X),Y,succ(Z)) :-
%%     add(X,Y,Z).

%% greater_than(succ(X),0).
%% greater_than(succ(X),X).

%% leaf(X).
%% tree(leaf(X)).
%% tree(tree(B1),tree(B2)).
%% swap(leaf(X),leaf(X)).
%% swap(tree(B1,B2),tree(B2Swapped,B1Swapped)):-
%%     swap(B1,B1Swapped),
%%     swap(B2,B2Swapped).


%% numeral(succ(X)) :- numeral(X).
%% numeral(0).

%% connected(1,2).
%% connected(3,4).
%% connected(5,6).
%% connected(7,8).
%% connected(9,10).
%% connected(12,13).
%% connected(13,14).
%% connected(15,16).
%% connected(17,18).
%% connected(19,20).
%% connected(4,1).
%% connected(6,3).
%% connected(4,7).
%% connected(6,11).
%% connected(14,9).
%% connected(11,15).
%% connected(16,12).
%% connected(14,17).
%% connected(16,19).

%% path(X,Y):-
%%     connected(X,Y).
%% path(X,Y):-
%%     connected(X,Z),
%%     path(Z,Y).

byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(singapore,auckland).
byPlane(losAngeles,auckland).

travel(X,Y):- byCar(X,Y).
travel(X,Y):- byTrain(X,Y).
travel(X,Y):- byPlane(X,Y).

travel(X,Y):-
    byCar(X,Z),
    travel(Z,Y).
travel(X,Y):-
    byTrain(X,Z),
    travel(Z,Y).
travel(X,Y):-
    byPlane(X,Z),
    travel(Z,Y).
