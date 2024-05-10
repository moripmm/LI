main :- EstatInicial = [0,0],    EstatFinal = [0,4],
        between(1, 1000, CostMax),                  % Busquem solució de cost 0; si no, de 1, etc.
        cami(CostMax, EstatInicial, EstatFinal, [EstatInicial], Cami),
        reverse(Cami, Cami1), write(Cami1), write(' amb cost '), write(CostMax), nl, halt.

cami(0, E, E, C, C).                                % Cas base: quan l'estat actual és l'estat final.
cami(CostMax, EstatActual, EstatFinal, CamiFinsAra, CamiTotal) :-
        CostMax > 0, 
        unPas(CostPas, EstatActual, EstatSeguent),  % En B.1 i B.2, CostPas és 1.
        \+ member(EstatSeguent, CamiFinsAra),
        CostMax1 is CostMax-CostPas,
        cami(CostMax1, EstatSeguent, EstatFinal, [EstatSeguent|CamiFinsAra], CamiTotal).


unPas(1,[N,M],[5,M]) :-
    N < 5.
unPas(1,[N,M],[0,M]) :-
    N > 0.
unPas(1,[N,M],[N,8]) :- 
    M < 8.
unPas(1,[N,M],[N,0]) :-
    M > 0.
unPas(1,[N,M],[0,Q]) :- 
    Q is M+N, Q =< 8.
unPas(1,[N,M],[0,8]) :- 
    Q is M+N, Q > 8.
unPas(1,[N,M],[Q,0]) :-
    Q is N+M, Q =< 5.
unPas(1,[N,M],[5,0]) :-
    Q is N+M, Q > 5.
unPas(1,[N,M],[Q,8]) :-
    Q is N-8+M, R is N+M, R >= 8.
unPas(1,[N,M],[5,Q]) :-
    Q is M-5+N, R is N+M, R >= 5.


