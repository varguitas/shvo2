nino(jose,6,costa_rica,[comparte,regala,perdona],[pelea],[peluche],5000).
nino(adrian,8,costa_rica,[comparte,regala],[pelea,roba],[peluche,carro],5000).
nino(julian,9,costa_rica,[comparte,regala,perdona],[pelea],[play3],5000).
nino(eduardo,10,costa_rica,[comparte,regala,perdona],[pelea],[trompo],5000).

go(L):-findall(X,accionBuena(perdona,X),L).
accionBuena(X,L):-nino(N,_,_,AB,_,_,_),busca(AB,X),L = N.
accionMala(X,L):-nino(N,_,_,_,AM,_,_),busca(AM,X),L = N.

busca([],Ac):-fail.
busca([H|T],Ac):-H=Ac.
busca([H|T],Ac):-busca(T,Ac).

obtenerFinal([H|T],Final):- T=[],Final = H.
obtenerFinal([H|T],Final):- obtenerFinal(T,Final).

revertir([],L,L).
revertir([HV|TV],L,LN):-revertir(TV,[HV|L],LN).

%	findall(X,accionBuena(perdona,X),L)   <--- devuelve lista que cumple con todo
