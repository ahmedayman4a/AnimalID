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

        animal_facts = []
        habitat_facts = []
        sound_facts = []
        skin_coating_facts = []
        size_facts = []
        diet_facts = []
        rules = set()

        for row in reader:
            animal = format_name(row['What is your favorite animal?'])
            habitat = format_habitat(row['What is the habitat of the animal?'])
            sound = format_sound(row['What sound does the animal make?'])
            skin_coating = format_skin_coating(row['What type of skin coating does the animal have?'])
            size = format_size(row['What size is the animal?'])
            diet = format_diet(row['What is the diet of the animal?'])

            animal_facts.append(f"animal({animal}).")
            habitat_facts.append(f"habitat({animal}, {habitat}).")
            sound_facts.append(f"sound({animal}, {sound}).")
            skin_coating_facts.append(f"skin_coating({animal}, {skin_coating}).")
            size_facts.append(f"size({animal}, {size}).")
            diet_facts.append(f"diet({animal}, {diet}).")

            # Create rules based on characteristics
            rules.add(f"identify_animal(A) :- skin_coating(A, {skin_coating}), sound(A, {sound}), animal(A).")

        with open(prolog_file_path, mode='w') as prologfile:
            for fact in sorted(animal_facts):
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in sorted(habitat_facts):
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in sorted(sound_facts):
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in sorted(skin_coating_facts):
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in sorted(size_facts):
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for fact in sorted(diet_facts):
                prologfile.write(fact + '\n')
            prologfile.write('\n')
            for rule in sorted(rules):
                prologfile.write(rule + '\n')

# Example usage
csv_file_path = 'data.csv'
prolog_file_path = 'animal_facts.pl'
generate_prolog_facts(csv_file_path, prolog_file_path)
