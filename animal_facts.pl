% Facts
animal(parrot).
animal(crocodile).
animal(lion).

habitat(parrot, mountains).
habitat(crocodile, mountains).
habitat(lion, swamp).

sound(parrot, silence).
sound(crocodile, bark).
sound(lion, snort).

skin_coating(parrot, scales).
skin_coating(crocodile, exoskeleton).
skin_coating(lion, exoskeleton).

size(parrot, medium).
size(crocodile, medium).
size(lion, large).

diet(parrot, carnivore).
diet(crocodile, carnivore).
diet(lion, carnivore).

% Rules
identify_animal(Animal,Habitant,Sound,Skin,Size,Diet) :- animal(Animal), habitat(Animal,Habitant), sound(Animal,Sound), skin_coating(Animal, Skin), size(Animal, Size), diet(Animal,Diet).
identify_animal(Animal,Sound) :- animal(Animal), sound(Animal,Sound).