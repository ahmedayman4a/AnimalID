% Animal facts
animal(elephant).
animal(eagle).
animal(tiger).
animal(whale).
animal(cheetah).
animal(dolphin).
animal(penguin).
animal(panda).
animal(bear).
animal(bee).
animal(shark).
animal(turtle).
animal(giraffe).
animal(kangaroo).
animal(wolf).
animal(fox).
animal(camel).
animal(rhino).
animal(owl).
animal(snake).
animal(frog).
animal(horse).
animal(peacock).
animal(bat).
animal(lion).
animal(octopus).
animal(crocodile).
animal(parrot).
animal(deer).
animal(monkey).

% Skin coating facts
skin_coating(elephant, thick_skin).
skin_coating(eagle, feathers).
skin_coating(tiger, fur).
skin_coating(whale, smooth_skin).
skin_coating(cheetah, fur).
skin_coating(dolphin, smooth_skin).
skin_coating(penguin, feathers).
skin_coating(panda, fur).
skin_coating(bear, fur).
skin_coating(bee, exoskeleton).
skin_coating(shark, rough_skin).
skin_coating(turtle, shell).
skin_coating(giraffe, fur).
skin_coating(kangaroo, fur).
skin_coating(wolf, fur).
skin_coating(fox, fur).
skin_coating(camel, fur).
skin_coating(rhino, thick_skin).
skin_coating(owl, feathers).
skin_coating(snake, scales).
skin_coating(frog, moist_skin).
skin_coating(horse, fur).
skin_coating(peacock, feathers).
skin_coating(bat, fur).
skin_coating(lion, fur).
skin_coating(octopus, soft_skin).
skin_coating(crocodile, scales).
skin_coating(parrot, feathers).
skin_coating(deer, fur).
skin_coating(monkey, fur).

% Size facts
size(elephant, large).
size(eagle, medium).
size(tiger, large).
size(whale, enormous).
size(cheetah, medium).
size(dolphin, medium).
size(penguin, medium).
size(panda, medium).
size(bear, large).
size(bee, small).
size(shark, large).
size(turtle, medium).
size(giraffe, large).
size(kangaroo, medium).
size(wolf, medium).
size(fox, small).
size(camel, large).
size(rhino, large).
size(owl, small).
size(snake, medium).
size(frog, small).
size(horse, large).
size(peacock, medium).
size(bat, small).
size(lion, large).
size(octopus, medium).
size(crocodile, large).
size(parrot, small).
size(deer, medium).
size(monkey, small).

% Habitat facts
habitat(elephant, savanna).
habitat(eagle, mountains).
habitat(tiger, forest).
habitat(whale, ocean).
habitat(cheetah, savanna).
habitat(dolphin, ocean).
habitat(penguin, antarctic).
habitat(panda, forest).
habitat(bear, forest).
habitat(bee, meadow).
habitat(shark, ocean).
habitat(turtle, ocean).
habitat(giraffe, savanna).
habitat(kangaroo, outback).
habitat(wolf, forest).
habitat(fox, forest).
habitat(camel, desert).
habitat(rhino, savanna).
habitat(owl, forest).
habitat(snake, forest).
habitat(frog, swamp).
habitat(horse, meadow).
habitat(peacock, forest).
habitat(bat, cave).
habitat(lion, savanna).
habitat(octopus, ocean).
habitat(crocodile, swamp).
habitat(parrot, tropical).
habitat(deer, forest).
habitat(monkey, jungle).

% Diet facts
diet(elephant, herbivore).
diet(eagle, carnivore).
diet(tiger, carnivore).
diet(whale, carnivore).
diet(cheetah, carnivore).
diet(dolphin, carnivore).
diet(penguin, carnivore).
diet(panda, herbivore).
diet(bear, omnivore).
diet(bee, herbivore).
diet(shark, carnivore).
diet(turtle, herbivore).
diet(giraffe, herbivore).
diet(kangaroo, herbivore).
diet(wolf, carnivore).
diet(fox, omnivore).
diet(camel, herbivore).
diet(rhino, herbivore).
diet(owl, carnivore).
diet(snake, carnivore).
diet(frog, carnivore).
diet(horse, herbivore).
diet(peacock, herbivore).
diet(bat, omnivore).
diet(lion, carnivore).
diet(octopus, carnivore).
diet(crocodile, carnivore).
diet(parrot, herbivore).
diet(deer, herbivore).
diet(monkey, omnivore).

% Sound facts
sound(elephant, trumpet).
sound(eagle, screech).
sound(tiger, roar).
sound(whale, song).
sound(cheetah, chirp).
sound(dolphin, click).
sound(penguin, squawk).
sound(panda, bleat).
sound(bear, growl).
sound(bee, buzz).
sound(shark, silence).
sound(turtle, silence).
sound(giraffe, hum).
sound(kangaroo, chortle).
sound(wolf, howl).
sound(fox, bark).
sound(camel, grunt).
sound(rhino, snort).
sound(owl, hoot).
sound(snake, hiss).
sound(frog, croak).
sound(horse, neigh).
sound(peacock, scream).
sound(bat, screech).
sound(lion, roar).
sound(octopus, silence).
sound(crocodile, growl).
sound(parrot, squawk).
sound(deer, bellow).
sound(monkey, chatter).

% Rule to identify an animal based on its characteristics
identify_animal(Animal, Habitat, Sound, Skin, Size, Diet) :-
    animal(Animal),
    habitat(Animal, Habitat),
    sound(Animal, Sound),
    skin_coating(Animal, Skin),
    size(Animal, Size),
    diet(Animal, Diet).

% identify_animal(Animal,Sound) :- animal(Animal), sound(Animal,Sound).

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
    ask_until_yes(['mountains', 'swamp', 'savanna', 'ocean', 'forest', 'antarctic', 'meadow', 'desert', 'outback', 'tropical', 'cave', 'jungle'], 'Does your animal live in the ~w? ', Habitat).

ask_sound(Sound) :-
    ask_until_yes(['bark', 'snort', 'silence', 'trumpet', 'screech', 'roar', 'song', 'chirp', 'click', 'squawk', 'bleat', 'growl', 'buzz', 'quack', 'hum', 'chortle', 'howl', 'woof', 'grunt', 'meow', 'hoot', 'hiss', 'croak', 'neigh', 'scream', 'screech', 'bellow', 'chatter'], 'Does your animal make a ~w? ', Sound).

ask_skin_coating(Skin) :-
    ask_until_yes(['fur', 'feathers', 'scales', 'smooth_skin', 'thick_skin', 'exoskeleton', 'shell', 'soft_skin', 'moist_skin'], 'Does your animal have ~w? ', Skin).

ask_size(Size) :-
    ask_until_yes(['small','medium', 'large','enormous'], 'Is your animal ~w? ', Size).

% ask_ancestor(Ancestor) :-
%     ask_until_yes(['crocodile', 'lion'], 'Is your animal a descendant of ~w? ', Ancestor).



main :-
    ask_diet(Diet),
    ask_habitat(Habitat),
    ask_sound(Sound),
    ask_skin_coating(Skin),
    ask_size(Size),
    identify_animal(Animal,Habitat,Sound,Skin,Size,Diet),
    % ask_ancestor(Ancestor),
    % format('Your animal is a descendant of ~w.', [Ancestor]), nl.
    format('Your animal\'s diet is ~w.', [Diet]), nl,
    format('Your animal lives in the ~w.', [Habitat]), nl,
    format('Your animal makes a ~w.', [Sound]), nl,
    format('Your animal has ~w.', [Skin]), nl,
    format('Your animal is ~w.', [Size]), nl,
    format('Your animal is a ~w.', [Animal]), nl,
    ask_another.

ask_another :-
    write('Do you want to guess another animal? (yes/no): '),
    read(Response),
    ( Response == yes -> main
    ; Response == no -> write('Goodbye!'), nl
    ; write('Please answer with yes or no.'), nl, ask_another
    ).


% Run the main predicate
:- main.


