% Ancestor relationships
parent(elephant, mammoth).
parent(tiger, saber_tooth_tiger).
parent(wolf, dire_wolf).
parent(bear, short_faced_bear).
parent(dolphin, ancient_whale).
parent(eagle, prehistoric_eagle).
parent(shark, megalodon).
parent(crocodile, prehistoric_crocodile).
parent(dog1,dog2).
parent(dog2,dog3).
parent(dog3,dog4).


% Recursive rule to determine if X is an ancestor of Y
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% Base case: an animal with no parent has an empty ancestor list
collect_ancestors(Animal, []) :-
    \+ parent(Animal, _).

% Recursive case: an animal with a parent
collect_ancestors(Animal, Ancestors) :-
    parent(Animal, Parent),
    collect_ancestors(Parent, ParentAncestors),
    Ancestors = [Parent | ParentAncestors].

% Base case: an animal with no parent has an empty ancestor list
collect_descendants(Animal, []) :-
    \+ parent(_, Animal).

% Recursive case: an animal with a parent
collect_descendants(Animal, Descendants) :-
    parent(Child, Animal),
    collect_descendants(Child, ParentDescendants),
    Descendants = [Child | ParentDescendants].

% Print the list of ancestors
% print_ancestors([]) :-
%     write('No ancestors found.'), nl.

print_list([ListA | Rest]) :-
    write(ListA), 
    (
        Rest == [] -> write(' .'), nl
    ;   write(' , '), print_list(Rest)
    ).


ask_ancestor_exist(Animal) :-
    write('Do you want to know your animal\'s ancestors? (yes/no): '),
    read(Response),
    ( Response == yes ->    collect_ancestors(Animal, Ancestors),
                            (Ancestors==[] -> write('No ancestors found for your animal.'), nl
                            ; write('The ancestors of your animal are: '), print_list(Ancestors)
                            )
    ; Response == no -> write('')
    ; write('Please answer with yes or no.'), nl, ask_ancestor_exist(Animal)
    ).

ask_descendant_exist(Animal) :-
    write('Do you want to know your animal\'s descendants ? (yes/no): '),
    read(Response),
    ( Response == yes ->    collect_descendants(Animal, Descendants),
                            (Descendants==[] -> write('No descendants found for your animal.'), nl
                            ; write('The descendants of your animal are: '), print_list(Descendants)
                            )
    ; Response == no -> write('')
    ; write('Please answer with yes or no.'), nl, ask_descendant_exist(Animal)
    ).

ask_another :-
    write('Do you want to guess another animal? (yes/no): '),
    read(Response),
    ( Response == yes -> main
    ; Response == no -> write('Goodbye!'), nl
    ; write('Please answer with yes or no.'), nl, ask_another
    ).

main :-
    Animal=dog4,
    format('Your animal is ~w.', [Animal]), nl,
    ask_ancestor_exist(Animal),
    ask_descendant_exist(Animal),
    % Ancestor_case=yes,
    % format('Your animal ancestors case is ~w.', [Ancestor_case]), nl,
    % Ancestors = [asser,ahmed],
    % New = [aloo,Ancestors],
    % (   Ancestor_case == yes -> ,write('YESSSSSSSSS'), nl
    %     ; write('NOOOOOOO'), nl
    % ),
    % format('Your animal ancestors are ~w.', [Ancestors]), nl,
    % ( Ancestor_case == yes -> 
    %    ( Ancestors==[] -> write('There are no ancestors for your Animal in our database'), nl 
    %    ;   format('Your animal ancestors are ~w.', [Ancestors]), nl 
    %    ).
    % ).
    ask_another.

% tok :-    
%     Animal=hamo,
%     format('Your animal is ~w.', [Animal]), nl.


% Run the main predicate
:- main.