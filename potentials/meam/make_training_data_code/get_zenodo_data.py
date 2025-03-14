import os
from zenodo_get import zenodo_get

doi = "10.5281/zenodo.14912402" # Plibrary, PBE
target_folder = os.path.join("./PBE", doi.split('/')[-1])

#doi = "10.5281/zenodo.14912399" # Plibrary, PBEsol
#target_folder = os.path.join("./PBEsol", doi.split('/')[-1])

os.makedirs(target_folder, exist_ok=True)
os.chdir(target_folder)

zenodo_get([doi])
