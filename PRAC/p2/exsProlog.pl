%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Notació:
%%   * "donat N" significa que l'argument N estarà instanciat inicialmente.
%%   * "ha de ser capaç de generar totes les respostes possibles" significa que
%%     si hi ha backtracking ha de poder generar la següent resposta, com el
%%     member(E,L) que per una llista L "donada" pot generar tots els elements E.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% En LI adapterem la "Notation of Predicate Descriptions" de SWI-Prolog per
%% descriure els predicats, prefixant cada argument amb un d'aquests 3 símbols:
%%   '+' quan l'argument ha d'estar necessàriament instanciat (no pot ser una
%%       variable sense instanciar). Pot ser ground (f(a) o 34)" o no (X+1 o g(a,Y)).
%%       Quan parlem de "donada L", llavors especficarem +L en la *descripció*.
%%       Per exemple, l'argument de +L del predicat esta_ordenada(+L).
%%   '-' quan l'argument ha de ser necessàriament una variable que quedarà
%%       instanciada, al satisfer-se el predicat, amb un cert terme que podem
%%       veure com un "resultat".
%%       Per exemple, l'argument -F en el predicat fact(+N,-F) que per un N donat,
%%       se satisfà fent que F sigui el valor N!.
%%   '?' quan s'accepta que l'argument pugui estar instanciat o no.
%%       Es tracta dels casos en que es diu "ha de poder generar la S i també
%%       comprovar una S donada". Llavors especificarem ?S en la *descripció*.
%%       Per exemple, l'argument ?S de suma(+L,?S).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% En aquests exercicis feu servir els predicats:
%%   * member(E,L)         en lloc de  pert(E,L)
%%   * append(L1,L2,L3)    en lloc de  concat(L1,L2,L3)
%%   * select(E,L,R)       en lloc de  pert_amb_resta(E,L,R)
%%   * permutation(L,P)    en lloc de  permutacio(L,P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% PROB. A =========================================================
% Escriu un predicat
% prod(+L,?P)  que signifiqui: P és el producte dels
% elements de la llista de enters donada L. Ha de poder generar la
% P i també comprovar una P donada

prod([],1).
prod([X|Y], R1) :- prod(Y,R2), R1 is X*R2.




% PROB. B =========================================================
% Escriu un predicat
% pescalar(+L1,+L2,?P) que signifiqui: P és el producte escalar dels
% vectors L1 i L2, on els vectors es representen com llistes
% d'enters. El predicat ha de fallar si els dos vectors
% tenen longituds diferents.
pescalar([],[],0).
pescalar([X1|Y1], [X2|Y2], R1) :- pescalar(Y1,Y2,R2), R1 is R2 + X1*X2, length(Y1, L1), length(Y2, L2), L1 = L2.






% PROB. C =========================================================
% Representant conjunts com llistes sense repeticions, escriu
% predicats per les operacions d'intersecció i unió de conjunts donats

% intersection(+L1,+L2,?L3)
intersection([],_,[]).
intersection([X1|Y1], L2, [X1|R1]) :- member(X1, L2),!, intersection(Y1, L2, R1).
intersection([_|Y1], L2, R1) :- intersection(Y1, L2, R1).



% union(+L1,+L2,?L3)
% Les llistes poden ser repetides? Si ho son, caldra fer una filtracio en R1
union([],L,L).
union([X1|Y1], L2, R1) :- member(X1, L2), !, union(Y1, L2, R1).
union([X1|Y1], L2, [X1|R1]) :- union(Y1, L2, R1).


% Per que no furula?
union2([],L,L).
union2([X1|Y1], L2, [X1|R1]) :- union(Y1, L2, R1),!.
union2([_|Y1], L2, R1) :- union(Y1, L2, R1).


% PROB. D =========================================================
% Usant append/3, escriu un predicat per calcular l'últim 
% element d'una llista donada, i un altre per calcular la llista
% inversa d'una llista donada.

% ultim(+L,?E)
ultim(L, X) :- append(_, [X], L).



% inversa(+L1,?L2)
inversa([], []).
inversa(L,[X | Y]) :-
append(T, [X], L),
inversa(T, Y),!.





% PROB. E =========================================================
% Escriu un predicat
% fib(+N,?F) que signifiqui: F és l'N-éssim nombre de Fibonacci
% per a la N donada. Aquests nombres es defineixen així:
% fib(1) = 1, fib(2) = 1, i si N > 2 llavors
% fib(N) = fib(N-1) + fib(N-2)
fib(1,1).
fib(2,1).
fib(N1,R1) :- N1 > 2, N2 is N1-1, N3 is N1-2, fib(N2,R2), fib(N3,R3), R1 is R2 + R3,!. 





% PROB. F =========================================================
% Escriu un predicat
% dados(+P,+N,-L) que signifiqui: la llista L expressa una forma de
% sumar P punts llançant N daus. Per exemple: si P és 5, i
% N és 2, una solució seria [1,4] (noteu que la longitud de L és N.
% Tant P com N venen instanciats. El predicat deu ser capaç de
% generar totes les solucions possibles,

dados(0, 0, []).
dados(P, N, [X|L]):- N > 0,  member(X, [1,2,3,4,5,6]), N1 is N - 1, P1 is P - X, dados(P1, N1, L).




% PROB. G =========================================================
% Escriu un predicat
% suma_la_resta(+L) que, donada una llista d'enters L, es satisfà si
% existeix algun element en L que és igual a la suma de la resta
% d'elements de L, i que altrament falla.
% Escriu abans un predicat
% suma(+L,?S) que, donada una llista d'enters L, se satisfà si S
% és la suma dels elements d'L.

% suma(+L,?S)
suma([], 0).
suma([L|L1], P):- suma(L1, P1), P is P1 + L.



% suma_la_resta(+L)
suma_la_resta(L):- append(L1, [X|L2], L), append(L1, L2, L3), suma(L3, X).





% PROB. H =========================================================
% Escriu un predicat
% card(+L) que, donada una llista d'enters L, escriba la llista
% que, para cada element d'L, diu quantes vegades surt aquest
% element en L.
% Per exemple, si fem la consulta
% card( [1,2,1,5,1,3,3,7] )  l'intèrpret escriurà:
% [[1,3],[2,1],[5,1],[3,2],[7,1]].

card(L) :- card_appears(L,R), write(R).

card_appears([],[]).
card_appears([X|Y],[[X,C]|Y1]):- card_count(X, [X|Y], C), delete([X|Y], X, D), card_appears(D,Y1).

card_count(_,[],0).
card_count(X,[X1|Y],C) :- card_count(X,Y,C1), X =:= X1, C is C1 + 1.
card_count(X,[X1|Y],C) :- card_count(X,Y,C1), X =\= X1, C is C1 + 0.







% PROB. I ========================================================
% Escriu un predicat
% esta_ordenada(+L) que signifiqui: la llista L de nombres enters
% està ordenada de menor a major.
% Per exemple, a la consulta:
% ?- esta_ordenada([3,45,67,83]).
% l'intèrpret respon yes, i a la consulta:
% ?- esta_ordenada([3,67,45]).
% respon no.

esta_ordenada([]) :- write("yes").
esta_ordenada([X|Y]) :- mes_petit_que_primer(X,Y), esta_ordenada(Y),!.
esta_ordenada(_) :- write("no").

mes_petit_que_primer(_,[]).
mes_petit_que_primer(X,[X1|_]) :- X =< X1.









% PROB. J ========================================================
% Escriu un predicat
% palíndroms(+L) que, donada una llista de lletres L escrigui
% totes les permutacions dels seus elements que siguin palíndroms
% (capicues). Per exemple, amb la consulta palindrom([a,a,c,c])
% s'escriu [a,c,c,a] i [c,a,a,c]
% (possiblement diverses vegades, no cal que eviteu les repeticions)
palindroms(L) :- permutation(L,P), es_palindrom(P), write(P), nl, false.

es_palindrom([]).
es_palindrom([_]).
es_palindrom([P|Y]) :- ultim(Y,U), P = U, append(L, [U], Y), es_palindrom(L),!.







% PROB. K ========================================================
% Volem obtenir en Prolog un predicat
% dom(+L) que, donada una llista L de fitxes de dominó (en el format
% indicat abaix), escrigui una cadena de dominófent servir *totes*
% les fitxes de L, o escrigui "no hi ha cadena" si no és possible.
% Per exemple,
% ?- dom( [ f(3,4), f(2,3), f(1,6), f(2,2), f(4,2), f(2,1) ] ).
% escriu la cadena correcta:
% [ f(2,3), f(3,4), f(4,2), f(2,2), f(2,1), f(1,6) ].
%
% També podem "girar" alguna fitxa como f(N,M), reemplaçant-la
% per f(M,N). Així, per:
% ?- dom( [ f(4,3), f(2,3), f(1,6), f(2,2), f(2,4), f(2,1) ] ).
% només hi ha cadena si es gira alguna fitxa (per exemple, hi ha
% mateixa cadena d'abans).
%
% El següent programa Prolog encara no té implementat els possibles
% girs de fitxes, ni té implementat el predicat ok(P), que
% significa: P és una cadena de dominó correcta (tal qual,
% sense necessitat de girar cap fitxa):

%p([],[]).
%p(L,[X|P]) :- select(X,L,R), p(R,P).

dom(L) :- p(L,P), ok(P), write(P), nl.
dom(_) :- write('no hi ha cadena'), nl.

% a) Escriu el predicat ok(+P) que falta.
ok([f(_,_)]).
ok([f(_,X)|L]) :- append([f(X1,_)],_,L), X = X1, ok(L),!.

% b) Estén el predicat p/2 per a que el programa també pugui
%    fer cadenes girant alguna de les fitxes de l'entrada.

p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).
p(L,[X1|P]) :- select(X,L,R), swap(X,X1), p(R,P).

swap(f(X1,X2),f(S1,S2)) :- S1 is X2, S2 is X1.





% PROB. L ========================================================
% Write in Prolog a predicate flatten(+L,?F) that ``flattens''
% (cat.: ``aplana'') the list F as in the example:
% ?- flatten( [a,b,[c,[d],e,[]],f,[g,h]], F ).
% F = [a,b,c,d,e,f,g,h]
flatten([],[]).
flatten([X|L], [R1|L1]) :- \+is_list(X),!, R1 = X, flatten(L,L1).
flatten([X|L], [_|L1]) :- append(X,L,L3), flatten(L3,L1).

% PROB. M ========================================================
% Consider two groups of 10 people each. In the first group,
% as expected, the percentage of people with lung cancer among smokers
% is higher than among non-smokers.
% In the second group, the same is the case.
% But if we consider the 20 people of the two groups together, then
% the situation is the opposite: the proportion of people with
% lung cancer is higher among non-smokers than among smokers!
% Can this be true? Write a little Prolog program to find it out.
cancer :- makeGroup(10,G1), makeGroup(10,G2), 
            percentageBound(G1), percentageBound(G2),  
            append(G1,G2,GT), percentageBound2(GT), !.

% 0=no S, no C; 1 = no S, C; 2 = S, no C, 3 = S, C
makeGroup(0,[]).
makeGroup(N,[X|L]) :- N > 0, N1 is N-1, between(0,3,X), makeGroup(N1,L).

percentageBound([]).
percentageBound(G) :- pbAux(G,PNSC,PSC), PNSC < PSC.

percentageBound2([]).
percentageBound2(G) :- pbAux(G,PNSC,PSC), PNSC > PSC.

pbAux([], 0, 0).
pbAux([X|L],P1,P2) :- X = 1, pbAux(L, P12, P22), P1 is P12 + 1, P2 is P22 + 0.
pbAux([X|L],P1,P2) :- X = 3, pbAux(L, P12, P22), P2 is P22 + 1, P1 is P12 + 0.
pbAux([_|L],P1,P2) :- pbAux(L, P12, P22), P2 is P22 + 0, P1 is P12 + 0.


%main :-
%    between(0,3,SC1),    % SC1:   "no.    smokers with    cancer group 1"
%    between(0,3,SNC1),   % SNC1:  "no.    smokers with no cancer group 1"
%    between(0,3,NSC1),   % NSC1:  "no. no smokers with    cancer group 1"
%    between(0,3,NSNC1),  % NSNC1: "no. no smokers with no cancer group 1"
%    10 is SC1+SNC1+NSC1+NSNC1,
%    ...

