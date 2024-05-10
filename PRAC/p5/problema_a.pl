

dades([[1,_,_,_,_,_],[2,_,_,_,_,_],[3,_,_,_,_,_],
        [4,_,_,_,_,_],[5,_,_,_,_,_]]).


condicions(D) :- 
    member([_,vermell,_,_,_,peru],D),
    member([_,_,_,gos,_,franca],D),
    member([_,_,pintor,_,_,japo],D),
    member([_,_,_,_,rom,xina],D), 
    member([1,_,_,_,_,hongria],D),
    member([_,verda,_,_,conyac,_],D),
    member([X,blanca,_,_,_,_],D),
    member([Y,verda,_,_,_,_],D),
    Y is X+1,
    member([_,_,escultor,cargols,_,_],D),
    member([_,groga,actor,_,_,_],D),
    member([3,_,_,_,cava,_],D),
    member([X1,_,_,cavall,_,_],D),
    member([Y1,_,actor,_,_,_],D),
    1 is abs(X1-Y1),
    member([X2,_,_,_,_,hongria],D),
    member([Y2,blava,_,_,_,_],D),
    1 is abs(X2-Y2),
    member([_,_,notari,_,whisky,_],D),
    member([X3,_,_,esquirol,_,_],D),
    member([Y3,_,metge,_,_,_],D),
    1 is abs(X3-Y3).




solucio :- 
    dades(D),
    condicions(D),!,
    member(X,D),
    write(X),
    fail.
