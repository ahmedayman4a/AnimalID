# Description: This script reads a CSV file containing animal data and generates Prolog facts from it.
# The CSV file should have the following columns:
# - What is your favorite animal?
# - What is the habitat of the animal?
# - What sound does the animal make?
# - What type of skin coating does the animal have?
# - What size is the animal?
# - What is the diet of the animal?
# The script generates the following Prolog facts:
# - animal(animal_name).
# - habitat(animal_name, habitat).
# - sound(animal_name, sound).
# - skin(animal_name, skin).
# - size(animal_name, size).
# - diet(animal_name, diet).


import csv

def format_name(name):
    return name.strip().lower().replace(" ", "_")

def format_habitat(habitat):
    return habitat.strip().lower().replace(" ", "_")

def format_sound(sound):
    return sound.strip().lower().replace(" ", "_")

def format_skin_coating(skin_coating):
    return skin_coating.strip().lower().replace(" ", "_")

def format_size(size):
    # Extracting size description from the string
    size_mapping = {
        'small (as Bee)': 'small',
        'medium (as Cat)': 'medium',
        'large (as a Lion)': 'large',
        'enormous (as an Elephant)': 'enormous'
    }
    return size_mapping.get(size.strip(), size.strip().lower().replace(" ", "_"))

def format_diet(diet):
    # Extracting diet description from the string
    diet_mapping = {
        'herbivore (eats plants)': 'herbivore',
        'carnivore (eats meat)': 'carnivore',
        'omnivore (eats both plants and meat)': 'omnivore'
    }
    return diet_mapping.get(diet.strip(), diet.strip().lower().replace(" ", "_"))

def generate_prolog_facts(csv_file_path, prolog_file_path):
    with open(csv_file_path, mode='r') as csvfile:
        reader = csv.DictReader(csvfile)

        animal_facts = []
        habitat_facts = []
        sound_facts = []
        skin_coating_facts = []
        size_facts = []
        diet_facts = []

        for row in reader:
            animal = format_name(row['What is your favorite animal?'])
            habitat = format_habitat(row['What is the habitat of the animal?'])
            sound = format_sound(row['What sound does the animal make?'])
            skin_coating = format_skin_coating(row['What type of skin coating does the animal have?'])
            size = format_size(row['What size is the animal?'])
            diet = format_diet(row['What is the diet of the animal?'])
            if(animal == "" or habitat == "" or sound == "" or skin_coating == "" or size == "" or diet == ""):
                continue
            if(animal == "animal" or habitat == "habitat" or sound == "sound" or skin_coating == "skin_coating" or size == "size" or diet == "diet"):
                continue
            if(animal_facts.count(f"animal({animal}).") > 0):
                continue
            animal_facts.append(f"animal({animal}).")
            habitat_facts.append(f"habitat({animal}, {habitat}).")
            sound_facts.append(f"sound({animal}, {sound}).")
            skin_coating_facts.append(f"skin_coating({animal}, {skin_coating}).")
            size_facts.append(f"size({animal}, {size}).")
            diet_facts.append(f"diet({animal}, {diet}).")

        with open(prolog_file_path, mode='w') as prologfile:
            prologfile.write("% Facts\n")
            for fact in animal_facts:
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in habitat_facts:
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in sound_facts:
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in skin_coating_facts:
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in size_facts:
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in diet_facts:
                prologfile.write(fact + '\n')

            prologfile.write("\n% Rules\n")
            prologfile.write("identify_animal(Animal,Habitant,Sound,Skin,Size,Diet) :- animal(Animal), habitat(Animal,Habitant), sound(Animal,Sound), skin_coating(Animal, Skin), size(Animal, Size), diet(Animal,Diet).\n")

            

# Example usage
csv_file_path = 'data.csv'
prolog_file_path = 'animal_facts.pl'
generate_prolog_facts(csv_file_path, prolog_file_path)
