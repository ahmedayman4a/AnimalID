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
# - parent(parent_animal, child_animal) (if the animal has a parent or child)

import csv
import os
from datetime import datetime

def format_name(name):
    return name.strip().lower().replace(" ", "_")

def format_habitat(habitat):
    return habitat.strip().lower().replace(" ", "_")

def format_sound(sound):
    return sound.strip().lower().replace(" ", "_")

def format_skin_coating(skin_coating):
    return skin_coating.strip().lower().replace(" ", "_")

def format_size(size):
    size_mapping = {
        'small (as Bee)': 'small',
        'medium (as Cat)': 'medium',
        'large (as a Lion)': 'large',
        'enormous (as an Elephant)': 'enormous'
    }
    return size_mapping.get(size.strip(), size.strip().lower().replace(" ", "_"))

def format_diet(diet):
    diet_mapping = {
        'herbivore (eats plants)': 'herbivore',
        'carnivore (eats meat)': 'carnivore',
        'omnivore (eats both plants and meat)': 'omnivore'
    }
    return diet_mapping.get(diet.strip(), diet.strip().lower().replace(" ", "_"))

def generate_prolog_facts(csv_file_path, prolog_file_path):
    with open(csv_file_path, mode='r') as csvfile:
        reader = csv.DictReader(csvfile)

        new_facts = []

        for row in reader:
            animal = row['What is your favorite animal?']
            if animal.lower() == 'another' or animal == '':
                animal = row['In case another what is the name of the animal?']
                if animal == '':
                    animal = 'Another'

            animal = format_name(animal)

            habitat = row['What is the habitat of the animal?']
            if habitat.lower() == 'another' or habitat == '':
                habitat = row['In case another what is the habitant of the animal?']
                if habitat == '':
                    habitat = 'Another'
            habitat = format_habitat(habitat)

            sound = row['What sound does the animal make?']
            if sound.lower() == 'another' or sound == '':
                sound = row['In case another what is the sound of the animal?']
                if sound == '':
                    sound = 'Another'

            sound = format_sound(sound)

            skin_coating = row['What type of skin coating does the animal have?']
            if skin_coating.lower() == 'another' or skin_coating == '':
                skin_coating = row['In case another what is the skin of the animal?']
                if skin_coating == '':
                    skin_coating = 'Another'

            skin_coating = format_skin_coating(skin_coating)

            size = format_size(row['What size is the animal?'])

            diet = format_diet(row['What is the diet of the animal?'])

            new_facts.append(f"animal({animal}).")
            new_facts.append(f"habitat({animal}, {habitat}).")
            new_facts.append(f"sound({animal}, {sound}).")
            new_facts.append(f"skin_coating({animal}, {skin_coating}).")
            new_facts.append(f"size({animal}, {size}).")
            new_facts.append(f"diet({animal}, {diet}).")

            descendant_animal = row['Is your favorite animal a descendant of another animal?']
            if descendant_animal.lower() != 'no' and descendant_animal != '':
                if descendant_animal.lower() == 'another' or descendant_animal != '':
                    descendant_animal = format_name(row['In case another what is the name of the descendant of the animal?'])
                    if descendant_animal == '':
                        descendant_animal = 'Another'
                new_facts.append(f"parent({descendant_animal}, {animal}).")

            ancestor_animal = row['Is your favorite animal an ancestor of another animal?']
            if ancestor_animal.lower() != 'no' and ancestor_animal != '':
                if ancestor_animal.lower() == 'another' or ancestor_animal != '':
                    ancestor_animal = format_name(row['In case another what is the name of the ancestor of the animal?'])
                    if ancestor_animal == '':
                        ancestor_animal = 'Another'
                new_facts.append(f"parent({animal}, {ancestor_animal}).")
            
            new_facts.append("")  # Add a newline between each group of facts

        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        header_directives = [
            ":- discontiguous animal/1.",
            ":- discontiguous habitat/2.",
            ":- discontiguous sound/2.",
            ":- discontiguous skin_coating/2.",
            ":- discontiguous size/2.",
            ":- discontiguous diet/2.",
            ":- discontiguous parent/2."
        ]

        header_directives_content = '\n'.join(header_directives) + '\n\n'
        new_content = header_directives_content + \
                      f"% New insertion in dataset at {timestamp}\n" + \
                      '\n'.join(new_facts) + '\n\n'

        if os.path.exists(prolog_file_path):
            with open(prolog_file_path, mode='r') as prologfile:
                existing_content = prologfile.read()

            with open(prolog_file_path, mode='w') as prologfile:
                prologfile.write(new_content)
                prologfile.write(existing_content)
        else:
            with open(prolog_file_path, mode='w') as prologfile:
                prologfile.write(new_content)

# Example usage
csv_file_path = 'data.csv'
prolog_file_path = 'animal_facts.pl'
generate_prolog_facts(csv_file_path, prolog_file_path)

