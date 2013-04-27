nino(jose,1,costa_rica,[comparte,regala,perdona],[pelea,roba,asalta,mata],[peluche],500000).
nino(adrian,8,costa_rica,[comparte,regala],[pelea,roba],[peluche,carro],500000).
nino(julian,9,costa_rica,[comparte,regala,perdona],[pelea],[play3],500000).
nino(eduardo,5,costa_rica,[comparte,regala,perdona],[pelea],[trompo],500000).

%%%%%%%%%%%%%%% ESTA ES LA ESTRUCTURA UTILIZADA POR JUGUETE %%%%%%%%%%%%%%%%%%%
% Estructura: juguete(nombre,marca,precio,edadMinima).		
juguete(peluche,univeler,10000,2).
juguete(carro,hasbro,500,3).
juguete(play3,sony,250000,9).
juguete(trompo,crtrompo,5000,10).							  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% FUNCION BUSCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCIONAMIENTO:
%    - La funcion busca recibe dos argumentos, la lista en la que se desea 
%	   buscar & el elemento a buscar. 
busca([],Ac):-fail.
busca([H|T],Ac):-H=Ac,!.
busca([H|T],Ac):-busca(T,Ac).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% OBTENER LISTA DE NIÑOS QUE REALIZAN UNA ACCION DETERMINADA %%%%
% ESTRUCTURA: accionBuena(Accion a Buscar, Lista en la que se desea obtener result).
accionBuena(Ac,L):-findall(X,accionBuenaAux(Ac,X),L).
accionMala(Ac,L):-findall(X,accionMalaAux(Ac,X),L).
accionBuenaAux(X,L):-nino(N,_,_,AB,_,_,_),busca(AB,X),L = N.
accionMalaAux(X,L):-nino(N,_,_,_,AM,_,_),busca(AM,X),L = N.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% OBTENER EL LARGO DE UNA LISTA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
largoLista([],C,R):-R is C.
largoLista([H|T],C,R):-M is C+1,largoLista(T,M,R).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% OBTENER LA LISTA DE NIÑOS BUENOS Y MALOS %%%%%%%%%%%%%%%%%%%%%%%
ninosMalos(L):-findall(X,ninosMalosAux(X),M),L = M.
ninosBuenos(L):-findall(X,ninosBuenosAux(X),M),L = M.
ninosMalosAux(L):-nino(N,_,_,AB,AM,_,_),largoLista(AB,0,CAB),largoLista(AM,0,CAM),CAM > CAB, L=N.
ninosBuenosAux(L):-nino(N,_,_,AB,AM,_,_),largoLista(AB,0,CAB),largoLista(AM,0,CAM),CAM =< CAB, L=N.
listaNinos(X,Y):-ninosBuenos(X),ninosMalos(Y),!.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% MOSTRAR LA INFORMACION DE TODOS LO NIÑOS: NOMBRE, EDAD,JUGUETES SOLICITADOS CON INFORMACION DE CADA UNO,
% & SI MERECE O NO LOS REGALOS...  (SIN FILTRO!)
mostrarDatos(L):-findall(X,mostrarListaRegalosAux(X),M),L = M,!.
mostrarListaRegalosAux(X):-nino(N,_,_,_,_,_,_),mostrarListaRegalos(N,L),X = L.
mostrarListaRegalos(N,L):-nino(N,E,_,AB,AM,R,_),merece(AB,AM),Merece = 'Merece todos los regalos',obtenerJuguetes(R,[],RI),L=[N,E,RI,Merece],!.
mostrarListaRegalos(N,L):-nino(N,E,_,AB,AM,R,_),merece(AM,AB),Merece = 'Merece medias de golfista',obtenerJuguetes(R,[],RI),L=[N,E,RI,Merece],!.
merece(LU,LD):-largoLista(LU,0,CU),largoLista(LD,0,CD),CU>=CD.
obtenerInfoJuguete(J,L):-juguete(J,Marca,Precio,Edad),L=[J,Marca,Precio,Edad].
obtenerJuguetes([],NL,R):-R = NL.
obtenerJuguetes([H|T],NL,R):-obtenerInfoJuguete(H,L),obtenerJuguetes(T,[L|NL],R).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mostrarDatosFiltrado(X):-findall(Z,mostrarListaRegalosFiltradoAux(Z),M),X = M.
obtenerEdadJ(N,Edad):-juguete(N,_,_,X),Edad = X.
obtenerPrecio(N,Pre):-juguete(N,_,P,_),Pre = P.
obtenerJuguetesF([],NL,R,_,_,_):- R = NL,!.
obtenerJuguetesF([H|T],NL,R,E,Max,Acum):-obtenerEdadJ(H,Ed),E>=Ed,obtenerPrecio(H,Pre),NuevoAcum is Acum+Pre,Max>=NuevoAcum,obtenerInfoJuguete(H,L),obtenerJuguetesF(T,[L|NL],R,E,Max,NuevoAcum),!.
obtenerJuguetesF([H|T],NL,R,E,Max,Acum):-obtenerJuguetesF(T,NL,R,E,Max,Acum),!.
mostrarListaRegalosFiltradoAux(X):-nino(N,_,_,_,_,_,_),mostrarListaRegalosFiltrado(N,L),X = L.
mostrarListaRegalosFiltrado(N,L):-nino(N,E,_,AB,AM,R,Max),merece(AB,AM),Merece = 'Merece todos los regalos',obtenerJuguetesF(R,[],Resul,E,Max,0),L=[N,E,Resul,Merece],!.
mostrarListaRegalosFiltrado(N,L):-nino(N,E,_,AB,AM,R,Max),merece(AM,AB),Merece = 'Merece medias de golfista',obtenerJuguetesF(R,[],Resul,E,Max,0),L=[N,E,Resul,Merece],!.

%	findall(X,accionBuena(perdona,X),L)   <--- devuelve lista que cumple con todo
% Obtener los regalos mas pedidos en orden descendente
%  1 - Utilizar la funcion buscar para saber si un regalo se encuentra en una lista
%  2 - Por cada niño se realiza la busqueda, & se mantiene un contador, que da el total de veces que aparece ese regalo en total

obtenerFinal([H|T],Final):- T=[],Final = H.
obtenerFinal([H|T],Final):- obtenerFinal(T,Final).

revertir([],L,L).
revertir([HV|TV],L,LN):-revertir(TV,[HV|L],LN).


