ask_until_yes([], _, _) :-
    write('No valid options left.'), nl, fail.

ask_until_yes([Option | Rest], QuestionFormat, Answer) :-
    format(QuestionFormat, [Option]),
    read(Response),
    ( Response == yes -> Answer = Option
    ; Response == no -> ask_until_yes(Rest, QuestionFormat, Answer)
    ; write('Please answer with yes or no.'), nl, ask_until_yes([Option | Rest], QuestionFormat, Answer)
    ).

ask_diet(Diet) :-
    ask_until_yes(['carnivore', 'omnivore', 'herbivore'], 'Is your animal\'s diet ~w? ', Diet).

ask_habitat(Habitat) :-
    ask_until_yes(['forest', 'desert', 'savanna', 'ocean'], 'Does your animal live in the ~w? ', Habitat).

main :-
    ask_diet(Diet),
    format('Your animal\'s diet is ~w.', [Diet]), nl,
    ask_habitat(Habitat),
    format('Your animal lives in the ~w.', [Habitat]), nl.

% Run the main predicate
:- main.


% ask_question(Question, Answer) :-
%     write(Question),   % Write the question
%     write(': '),       % Write a colon for better readability
%     read(Answer).      % Read the user's input into the variable Answer

% main :-
%     ask_question('What is your animal diet?', Diet),
%     ask_question('Where is your animal habitant?', Age),
%     write('Hello, '), write(Name), write('! You are '), write(Age), write(' years old.'), nl.

% % Run the main predicate
% :- main.
