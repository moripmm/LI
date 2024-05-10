main :- EstatInicial = [3,3,0,0],    EstatFinal = [0,0,3,3],
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



%% De dreta a esquerra
unPas(1,[M1,C1,M2,C2],[M1N,C1,M2N,C2]) :-
    M1 > 0,  M1N is M1-1, M2N is M2+1, M1N >= C1.
unPas(1,[M1,C1,M2,C2],[M1,C1N,M2,C2N]) :-
    C1 > 0,  C1N is C1-1, C2N is C2+1, M2 >= C2N.
unPas(1,[M1,C1,M2,C2],[M1N,C1,M2N,C2]) :-
    M1 > 0,  M1N is M1-2, M2N is M2+2, M1N >= C1.
unPas(1,[M1,C1,M2,C2],[M1,C1N,M2,C2N]) :-
    C1 > 0,  C1N is C1-2, C2N is C2+2, M2 >= C2N.
unPas(1,[M1,C1,M2,C2],[M1N,C1N,M2N,C2N]) :-
    M1N is M1-1, C1N is C1-1, M2N is M2+1, C2N is C2+1, C1 > 0, M1 > 0.

%% De esquerra a dreta
unPas(1,[M1,C1,M2,C2],[M1N,C1,M2N,C2]) :-
    M2 > 0,  M2N is M2-1, M1N is M1+1, M2N >= C2.
unPas(1,[M1,C1,M2,C2],[M1,C1N,M2,C2N]) :-
    C2 > 0, C1N is C1+1, C2N is C2-1, M1 >= C1N.
unPas(1,[M1,C1,M2,C2],[M1N,C1,M2N,C2]) :-
    M2 > 0,  M1N is M1+2, M2N is M2-2, M2N >= C2.
unPas(1,[M1,C1,M2,C2],[M1,C1N,M2,C2N]) :-
    C2 > 0,  C1N is C1+2, C2N is C2-2, M1 >= C1N.
unPas(1,[M1,C1,M2,C2],[M1N,C1N,M2N,C2N]) :-
    M1N is M1+1, C1N is C1+1, M2N is M2-1, C2N is C2-1, C1 > 0, M1 > 0.
