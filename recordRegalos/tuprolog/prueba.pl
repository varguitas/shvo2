/* Base de conocimientos de los niños */
nino(jose,6,costa_rica,[comparte,regala,perdona],[pelea],[peluche,compu],5000).
nino(adrian,8,costa_rica,[comparte,regala],[pelea,roba],[peluche,carro],5000).
nino(julian,9,costa_rica,[comparte,regala,perdona],[pelea],[play3],5000).
nino(eduardo,10,costa_rica,[comparte,regala,perdona],[pelea],[trompo,xbox,compu,play3],5000).
nino(jose,6,costa_rica,[comparte,regala,perdona],[pelea],[peluche,play3,carro,oso],5000).
nino(adrian,8,costa_rica,[comparte,regala],[pelea,roba],[barby,oso,compu,ropa],5000).
nino(julian,9,costa_rica,[comparte,regala,perdona],[pelea],[play3,helicoptero,compu,pistola],5000).
nino(eduardo,10,costa_rica,[comparte,regala,perdona],[pelea],[trompo,perro,compu],5000).
juguete([peluche,play3,trompo,carro,compu,xbox,ropa,helicoptero,perro,pistola,muneca,barby,oso]).
nino(maria,9,costa_rica,[comparte,regala],[pelea,roba],[barby,perro,compu,peluche,play3],5000).

/*-----------------------------------------------------------------------------*/


/*Devuelve true si Ac se encuentra en la lista recibida | busca([lista],Ac).*/
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

/* Ordena la lista de los juguetes de mayor a menor con la lista que fue generada anteriormente en listaRecord(R). */
ordena([],[]):-!.
ordena([H|T],S):-ordena(T,R),inserta(H,R,S).
inserta(X,[],[X]):-!.
inserta([C|X],[[J|H]|T],[[C|X],[J|H]|T]):-X>=H,!.
inserta([C|X],[[J|H]|T],[[J|H]|S]):-inserta([C|X],T,S).

recordRegalos(R):-listaRecord(Z),ordena(Z,R).

