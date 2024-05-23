# Animal Identification Application in Prolog

This application is designed to identify animals based on user-provided characteristics and provide additional lineage information (ancestors and descendants) if desired. The application is implemented in Prolog, leveraging its logical programming capabilities to manage facts, rules, and recursive queries efficiently.

## Features

### 1. Animal Identification

The core feature of the application is to identify an animal based on the following characteristics:
- **Habitat**: The natural environment where the animal lives.
- **Sound**: The characteristic sound made by the animal.
- **Skin Coating**: The type of skin covering (fur, feathers, scales, etc.).
- **Size**: The general size category of the animal (small, medium, large, enormous).
- **Diet**: The dietary habits of the animal (carnivore, herbivore, omnivore).

### 2. Ancestral Information

Once an animal is identified, the application can provide information about its ancestors. This feature helps users understand the evolutionary lineage of the identified animal.

### 3. Descendant Information

In addition to ancestors, the application can also provide information about the descendants of the identified animal, offering a complete lineage view.

## Implementation Details

### Data Representation

The application uses facts to represent data about animals, including their characteristics and relationships.

#### Animal Facts

```prolog
animal(elephant).
animal(eagle).
...
animal(monkey).
```

#### Characteristics Facts

Each characteristic is represented with its respective predicate:

- **Skin Coating**:

```prolog
skin_coating(elephant, thick_skin).
skin_coating(eagle, feathers).
...
```

- **Size**:

```prolog
size(elephant, large).
size(eagle, medium).
...
```

- **Habitat**:

```prolog
habitat(elephant, savanna).
habitat(eagle, mountains).
...
```

- **Diet**:

```prolog
diet(elephant, herbivore).
diet(eagle, carnivore).
...
```

- **Sound**:

```prolog
sound(elephant, trumpet).
sound(eagle, screech).
...
```

### Relationship Facts

Parent-child relationships are defined to support ancestral and descendant queries:

```prolog
parent(elephant, mammoth).
parent(tiger, saber_tooth_tiger).
...
parent(dog3, dog4).  % For testing
```

### Identification Rule

The `identify_animal/6` predicate identifies an animal based on user-provided characteristics:

```prolog
identify_animal(Animal, Habitat, Sound, Skin, Size, Diet) :-
    animal(Animal),
    habitat(Animal, Habitat),
    sound(Animal, Sound),
    skin_coating(Animal, Skin),
    size(Animal, Size),
    diet(Animal, Diet).
```

### Ancestral and Descendant Queries

#### Ancestor Query

The `ancestor/2` rule recursively determines if one animal is an ancestor of another:

```prolog
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```

To collect all ancestors of a given animal, `collect_ancestors/2` is used:

```prolog
collect_ancestors(Animal, []) :-
    \+ parent(Animal, _).

collect_ancestors(Animal, Ancestors) :-
    parent(Animal, Parent),
    collect_ancestors(Parent, ParentAncestors),
    Ancestors = [Parent | ParentAncestors].
```

#### Descendant Query

Similarly, the `descendant/2` rule and `collect_descendants/2` predicate are used to determine and collect all descendants:

```prolog
collect_descendants(Animal, []) :-
    \+ parent(_, Animal).

collect_descendants(Animal, Descendants) :-
    parent(Child, Animal),
    collect_descendants(Child, ParentDescendants),
    Descendants = [Child | ParentDescendants].
```

### User Interaction

The main interaction loop is managed by the `main/0` predicate, which guides the user through a series of questions to gather characteristics and identify the animal. Additional queries for ancestors and descendants are also included.

```prolog
main :-
    ask_diet(Diet),
    ask_habitat(Habitat),
    ask_sound(Sound),
    ask_skin_coating(Skin),
    ask_size(Size),

    ( identify_animal(Animal, Habitat, Sound, Skin, Size, Diet) -> 
        format('Your animal\'s diet is ~w.', [Diet]), nl,
        format('Your animal lives in the ~w.', [Habitat]), nl,
        format('Your animal makes a ~w.', [Sound]), nl,
        format('Your animal has ~w.', [Skin]), nl,
        format('Your animal is ~w.', [Size]), nl,
        format('Your animal is a ~w.', [Animal]), nl,
        ask_ancestor_exist(Animal),
        ask_descendant_exist(Animal)
    ; 
        write('No animal found with the given characteristics.'), nl 
    ),
    ask_another.
```

The user can choose whether to get information about ancestors or descendants through interactive prompts:

```prolog
ask_ancestor_exist(Animal) :-
    write('Do you want to know your animal\'s ancestors? (yes/no): '),
    read(Response),
    ( Response == yes -> collect_ancestors(Animal, Ancestors),
                          (Ancestors == [] -> write('No ancestors found for your animal.'), nl
                          ; write('The ancestors of your animal are: '), print_list(Ancestors)
                          )
    ; Response == no -> write('')
    ; write('Please answer with yes or no.'), nl, ask_ancestor_exist(Animal)
    ).

ask_descendant_exist(Animal) :-
    write('Do you want to know your animal\'s descendants? (yes/no): '),
    read(Response),
    ( Response == yes -> collect_descendants(Animal, Descendants),
                          (Descendants == [] -> write('No descendants found for your animal.'), nl
                          ; write('The descendants of your animal are: '), print_list(Descendants)
                          )
    ; Response == no -> write('')
    ; write('Please answer with yes or no.'), nl, ask_descendant_exist(Animal)
    ).
```

## Conclusion

This Prolog application provides a comprehensive system for identifying animals based on user input and exploring their evolutionary lineage. The use of logical rules and recursive queries showcases Prolog's strength in handling such tasks efficiently. The interactive nature of the application ensures an engaging user experience, while the additional features of ancestor and descendant queries add significant educational value.