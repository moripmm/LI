resposta(Codi,Intent,E,D) :-
        inner_resposta(Codi,Codi,Intent,E,D,_),!.

inner_resposta(_,[],[],0,0,0).
inner_resposta(CodiOr,[X|Codi], [Y|Intent], E, D, T) :-
        X == Y,
        inner_resposta(CodiOr,Codi,Intent,E1,_,T1),
    	T is T1 + 1,
        E is E1 + 1,
        D is T - E.
inner_resposta(CodiOr,[X|Codi], [Y|Intent], E, D, T) :-
        X \== Y,
        member(Y, CodiOr),
        inner_resposta(CodiOr, Codi, Intent, E, _, T1),
        T is T1 + 1,
        D is T - E.
inner_resposta(CodiOr,[X|Codi], [Y|Intent], E, D, T) :-
        X \== Y,
        \+member(Y,CodiOr),
        inner_resposta(CodiOr, Codi, Intent, E, _, T),
    	D is T - E.
