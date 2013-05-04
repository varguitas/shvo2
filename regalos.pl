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
<<<<<<< HEAD
/*-----------------------------------------------------------------------------*/

/*Devuelve true si Ac se encuentra en la lista recibida | busca([lista],Ac). */
=======
nino(maria,9,costa_rica,[comparte,regala],[pelea,roba],[barby,perro,peluche,play3],5000).

/*-----------------------------------------------------------------------------*/

/*Devuelve true si Ac se encuentra en la lista recibida | busca([lista],Ac).*/
>>>>>>> 2588a2ea76fccade46702c326fa1e6a1c223e9f0
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

<<<<<<< HEAD
<<<<<<< HEAD
/*Algoritmo de ordenamiento de prolog*/


=======
%Algoritmo_de_ordenamiento_de_listas
>>>>>>> 2588a2ea76fccade46702c326fa1e6a1c223e9f0
=======
%Algoritmo_de_ordenamiento_de_listas_simples.
>>>>>>> 80c124df1a5e21da850f40db275d89d5c07e29d4
ordena([],[]):-!.
ordena([H|T],S):-ordena(T,R),inserta(H,R,S),!.
inserta(X,[],[X]).
inserta(X,[H|T],[X,H|T]):-X>=H,!.
inserta(X,[H|T],[H|S]):-inserta(X,T,S).
<<<<<<< HEAD
<<<<<<< HEAD

=======
 
=======
	
>>>>>>> 80c124df1a5e21da850f40db275d89d5c07e29d4
%Concatenar_Listas
concatenar([],L,L). 
concatenar([X|L1],L2,[X|L3]):-concatenar(L1,L2,L3).

recordRegalos(R):-listaRecord(Z),ordena2(Z,R).

%Algoritmo_de_ordenamiento_para_el_programa
ordena2([],[]):-!.
ordena2([H|T],S):-ordena2(T,R),inserta2(H,R,S),!.
inserta2(X,[],[X]).
inserta2([C|X],[[J|H]|T],[[C|X],[J|H]|T]):-X>=H,!.
inserta2([C|X],[[J|H]|T],[[J|H]|S]):-inserta2([C|X],T,S).
>>>>>>> 2588a2ea76fccade46702c326fa1e6a1c223e9f0
