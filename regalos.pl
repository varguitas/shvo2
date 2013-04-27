/* Base de conocimientos de los niños */
nino(jose,6,costa_rica,[comparte,regala,perdona],[pelea],[peluche],5000).
nino(adrian,8,costa_rica,[comparte,regala],[pelea,roba],[peluche,carro],5000).
nino(julian,9,costa_rica,[comparte,regala,perdona],[pelea],[play3],5000).
nino(eduardo,10,costa_rica,[comparte,regala,perdona],[pelea],[trompo,xbox,play3],5000).
nino(jose,6,costa_rica,[comparte,regala,perdona],[pelea],[peluche,play3,carro,oso],5000).
nino(adrian,8,costa_rica,[comparte,regala],[pelea,roba],[barby,oso,ropa],5000).
nino(julian,9,costa_rica,[comparte,regala,perdona],[pelea],[play3,helicoptero,pistola],5000).
nino(eduardo,10,costa_rica,[comparte,regala,perdona],[pelea],[trompo,perro,compu],5000).
juguete([peluche,play3,trompo,carro,compu,xbox,ropa,helicoptero,perro,pistola,muñeca,barby,oso]).
/*-----------------------------------------------------------------------------*/

/*Devuelve true si Ac se encuentra en la lista recibida | busca([lista],Ac). */
busca([],Ac):-fail.
busca([H|T],Ac):-H=Ac,!.
busca([H|T],Ac):-busca(T,Ac).

regaloaux(X,Nomb):-nino(Nomb,_,_,_,_,Lst,_),busca(Lst,X).
regalo(X,L):-findall(Nomb,regaloaux(X,Nomb),M),L=M.

/*Devuelve el largo de la lista para saber cuantos elementos tiene*/
largoLista([],C,R):-R is C.
largoLista([H|T],C,R):-M is C+1,largoLista(T,M,R).

/*Cuenta la cantidad de juguetes y hace una lista de estos*/
listaRecord(R):-juguete(Z),contarJuguete(Z,[],R).
contarJuguete([],ListaTotal,R):-R=ListaTotal,!.
contarJuguete([H|T],ListaNueva,R):-regalo(H,Result),largoLista(Result,0,Total),contarJuguete(T,[[H,Total]|ListaNueva],R).

/*Algoritmo de ordenamiento de prolog*/


ordena([],[]):-!.
ordena([H|T],S):-ordena(T,R),inserta(H,R,S),!.
inserta(X,[],[X]).
inserta(X,[H|T],[X,H|T]):-X>=H,!.
inserta(X,[H|T],[H|S]):-inserta(X,T,S).

