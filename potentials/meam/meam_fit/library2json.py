import json

def parse_meam_file(file_path):
    elements = {}
    with open(file_path, 'r') as file:
        lines = file.readlines()
        i = 0
        while i < len(lines):
            line = lines[i].strip()
            if line.startswith("'"):
                element_data = {}
                element_name, lat, z, ielement, atwt = line.split()
                element_data["lat"] = lat.strip("'")
                element_data["z"] = int(float(z))  # Convert to float first, then to int
                element_data["ielement"] = int(float(ielement))  # Convert to float first, then to int
                element_data["atwt"] = float(atwt)
                
                i += 1
                alpha, b0, b1, b2, b3, alat, esub, asub = map(float, lines[i].split())
                element_data["alpha"] = alpha
                element_data["b0"] = b0
                element_data["b1"] = b1
                element_data["b2"] = b2
                element_data["b3"] = b3
                element_data["alat"] = alat
                element_data["esub"] = esub
                element_data["asub"] = asub
                
                i += 1
                t0, t1, t2, t3, rozero, ibar = map(float, lines[i].split())
                element_data["t0"] = t0
                element_data["t1"] = t1
                element_data["t2"] = t2
                element_data["t3"] = t3
                element_data["rozero"] = rozero
                element_data["ibar"] = int(ibar)
                
                elements[element_name.strip("'")] = element_data
            i += 1
    
    return elements

# Parse the MEAM file and convert to JSON format
meam_file_path = 'library.meam'
elements_data = parse_meam_file(meam_file_path)

# Save the JSON data to a file
json_file_path = 'library.json'
with open(json_file_path, 'w') as json_file:
    json.dump(elements_data, json_file, indent=4)

print(f"Converted MEAM data to JSON format and saved to {json_file_path}")
