/*



  astar algorithm

trace this query carefully
query=>>
astar(cairo,dahab,_,G,A)


G is total cost

A is absolute  path  without day or flight name


astars(cairo,dahab,mo,2,H,J)

2 => minimum time
m => day
H is path  with name of flight and satrt and end time
J is total cost

<3 <3 <3 <3 <3

?????? ??? ???? ????? ???????
??? ???? ???? ???? ????? ???????

*/









 %Levels Maximum Level is 4 %
  
  :-op(50,xfy,:).






timetable(alex,cairo,[ 9:40/10:50/ba4733/alldays,13:40/14:50/ba4773/alldays,19:40/20:50/ba4833/[mo,tu,we,th,fr,su]]).
timetable(cairo,alex,[ 9:40/10:50/ba4732/alldays,11:40/12:50/ba4752/alldays,18:40/19:50/ba4822/[mo,tu,we,th,fr]]).
timetable(cairo,mounofia,[13:20/16:20/jp212/[mo,tu,we,fr,su],16:30/19:30/ba471/[mo,we,th,sa]]).
timetable(cairo,matrouh,[ 9:10/11:45/ba614/alldays,14:45/17:20/sr805/alldays]).
timetable(y,x,[ 9:40/10:50/ba4733/alldays,13:40/14:50/ba4773/alldays,19:40/20:50/ba4833/[mo,tu,we,th,fr,su]]).
timetable(alex,y,[ 9:40/10:50/ba4733/alldays,13:40/14:50/ba4773/alldays,19:40/20:50/ba4833/[mo,tu,we,th,fr,su]]).
timetable(x,dahab,[ 9:40/10:50/ba4733/alldays,13:40/14:50/ba4773/alldays,19:40/20:50/ba4833/[mo,tu,we,th,fr,su]]).
timetable(dahab,f,[ 9:40/10:50/ba4733/[mo,tu,we,th,fr,su],13:40/14:50/ba4773/[mo,tu,we,th,fr,su],19:40/20:50/ba4833/[mo,tu,we,th,fr,su]]).
timetable(cairo,dahab,[ 8:30/11:20/ba510/alldays,11:00/13:50/az459/alldays]).
timetable(mounofia,matrouh,[11:30/12:40/jp322/[tu,th,mo]]).
timetable(mounofia,cairo,[11:10/12:20/jp211/[mo,tu,we,fr,su],20:30/21:30/ba472/[mo,we,th,sa]]).
timetable(dahab,cairo,[ 9:10/10:00/az458/alldays,12:20/13:10/ba511/alldays]).
timetable(dahab,matrouh,[ 9:25/10:15/sr621/alldays,12:45/13:35/sr623/alldays]).
timetable(matrouh,mounofia,[13:30/14:40/jp323/[tu,th]]).
timetable(matrouh,cairo,[ 9:00/ 9:40/ba613/[mo,tu,we,th,fr,sa],16:10/16:55/sr806/[mo,tu,we,th,fr,su]]).
timetable(matrouh,dahab,[ 7:55/ 8:45/sr620/alldays]).


/*area(Number,langitude,latirtudde).*/

area(alex,20,80).
area(cairo,50,30).
area(mounofia,100,100).
area(matrouh,90,70).
area(y,70,50).
area(x,110,50).
area(dahab,150,90).
area(f,150,90).


/*Way(CityA,CityB,time in min).*/
way(alex,cairo,70).
way(cairo,alex,70).
way(cairo,mounofia,180).
way(cairo,matrouh,155).
way(y,x,70).
way(alex,y,70).
way(x,dahab,70).
way(dahab,f,70).
way(cairo,dahab,110).
way(mounofia,matrouh,70).
way(mounofia,cairo,70).
way(dahab,cairo,50).
way(dahab,matrouh,50).
way(matrouh,mounofia,70).
way(matrouh,cairo,40).
way(matrouh,dahab,50).
   %%% Searching Algoritms %%%

astar(Start,Final,_,Tp,L3):-
      estimation(Start,Final,E),
      astar1([(E,E,0,[Start])],Final,_,Tp,L3).

astar1([(_,_,Tp,[Final|R])|_],Final,[Final|R],Tp,L3):-
reverse([Final|R],L3).

astar1([(_,_,P,[X|R1])|R2],Final,C,Tp,L3):-
       findall((NewSum,E1,NP,[Z,X|R1]),
             (way(X,Z,V),
               not(member(Z,R1)),
               NP is P+V,
               estimation(Z,Final,E1),
               NewSum is E1+NP),L),
append(R2,L,R3),
sort(R3,R4),
astar1(R4,Final,C,Tp,L3).


estimation(C1,C2,Est):- area(C1,X1,Y1),area(C2,X2,Y2), DX is X1-X2,DY is Y1-Y2,
                     Est is sqrt(DX*DX+DY*DY).



           am([H],Day,[]).
           am([H,S|T],Day,[G|F]):-
                route(H,S,Day,G,Y),
                 am([S|T],Day,F).

 astars(Start,End,Day,Y,H,Tp):-
  astar(Start,End,_,Tp,S),
  am(S,Day,H),
  transfer(Y,Tp).


route(P1,P2,Day,[P1/P2/Fnum/Deptime/Arrtime],S) :-
flight(P1,P2,Day,Fnum,Deptime,Arrtime),
dur(Deptime, Arrtime,S).


route1(P1,P2,Day,[(P1/P3/Fnum1/Dep1/Arr1)|RestRoute],S):-
flight(P1,P3,Day,Fnum1,Dep1,Arr1),
dur(Dep1, Arr1,T),
route(P3,P2,Day,RestRoute,A),
S is T + A ,
deptime(RestRoute,Dep2).


route2(P1,P2,Day,[U|Y],S):-
route1(P1,P3,Day,U,Ss),
route(P3,P2,Day,Y,A),
S is Ss + A .


route3(P1,P2,Day,[U|Y],S):-
route2(P1,P3,Day,U,Ss),
route(P3,P2,Day,Y,A),
S is Ss + A .




flight(Place1,Place2,Day,Fnum,Deptime,Arrtime) :-
timetable(Place1,Place2,Flightlist),
member(Deptime/Arrtime/Fnum/Daylist,Flightlist),
flyday(Day,Daylist).


flyday(Day,Daylist) :- member(Day,Daylist).
flyday(Day,alldays) :- member(Day,[mo,tu,we,th,fr,sa,su]).
deptime([P1/P2/Fnum/Dep|_],Dep).


dur(Hours1:Mins1,Hours2:Mins2,S) :-
S  is (60 * (Hours2 -Hours1) + Mins2- Mins1) .

transfer(A,B) :-
( (A * 60) ) >= B.

member(X,[X|_]).
member(X,[_|L]) :- member(X,L).

 answer(P1,P2,Day,N,R,S):-
  route(P1,P2,Day,R,S),
  transfer(N,S);
  route1(P1,P2,Day,R,S),
  transfer(N,S);
  route2(P1,P2,Day,R,S),
  transfer(N,S);
  route3(P1,P2,Day,R,S),
  transfer(N,S).