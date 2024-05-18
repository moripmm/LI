main :- EstatInicial = [1,2,5,8,-1, 0,0,0,0,-2],    EstatFinal = [0,0,0,0,-2 1,2,5,8,-1],  
	%-1 / -2: esta la llanterna/ no esta la llanterna
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



%% De inici a final (la llanterna ha d'estar a l'inici)
% una persona unPas(1,[1,_,_,_,-1, 0,_,_,_,-2],[0,_,_,_,-2, 1,_,_,_,-1]).
unPas(1,[1,A,B,C,-1, 0,D,E,F,-2],[0,A,B,C,-2, 1,D,E,F,-1]).
unPas(5,[A,B,5,C,-1, D,E,0,F,-2],[A,B,0,C,-2, D,E,5,F,-1]).
unPas(8,[A,B,C,8,-1, D,E,F,8,-2],[A,B,C,0,-2, D,E,F,8,-1]).
% dues persones
unPas(2,[1,2,A,B,-1, 0,0,E,F,-2],[0,0,A,B,-2, 1,2,E,F,-1]).
unPas(5,[1,A,5,B,-1, 0,C,0,D,-2],[0,A,0,B,-2, 1,A,5,B,-1]).
unPas(8,[1,A,B,8,-1, 0,C,D,0,-2],[0,A,B,0,-2, 1,C,D,8,-1]).
unPas(5,[A,2,5,B,-1, C,0,0,D,-2],[A,0,0,B,-2, C,2,5,D,-1]).
unPas(8,[A,2,B,8,-1, C,0,D,0,-2],[A,0,B,0,-2, C,2,D,8,-1]).
unPas(8,[A,B,5,8,-1, C,D,0,0,-2],[B,A,0,0,-2, C,D,5,8,-1]).


%% De final a inici (la llanterna ha d'estar al final)
% una persona
unPas(1,[0,A,B,C,-2, 1,D,E,F,-1],[1,A,B,C,-1, 0,D,E,F,-2]).
unPas(2,[A,0,B,C,-2, D,2,E,F,-1],[A,2,B,C,-1, D,0,E,F,-2]).
unPas(5,[A,B,0,C,-2, D,E,5,F,-1],[A,B,5,C,-1, D,E,0,F,-2]).
unPas(8,[A,B,C,0,-2, D,E,F,8,-1],[A,B,C,8,-1, D,E,F,8,-2]).
% dues persones
unPas(2,[0,0,A,B,-2, 1,2,C,D,-1],[1,2,E,F,-1, A,B,C,D,-2]).
unPas(5,[0,A,0,B,-2, 1,C,5,D,-1],[1,A,5,B,-1, 0,C,0,D,-2]).
unPas(8,[0,A,B,0,-2, 1,C,D,8,-1],[1,A,B,8,-1, 0,C,D,0,-2]).
unPas(5,[A,0,0,B,-2, C,2,5,D,-1],[A,2,5,B,-1, C,0,0,D,-2]).
unPas(8,[A,0,B,0,-2, C,2,D,8,-1],[A,2,B,8,-1, C,0,D,0,-2]).
unPas(8,[A,B,0,0,-2, C,D,5,8,-1],[A,B,5,8,-1, C,D,0,0,-2]).


