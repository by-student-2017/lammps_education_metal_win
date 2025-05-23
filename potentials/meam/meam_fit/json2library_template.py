import json

element = 'Xelement' # Specify the element to extract

# Load the JSON file
with open("library.json", "r") as file:
    data = json.load(file)

# Check if the specified element exists in the data
if element in data:
    values = data[element]

    # Define the MEAM file format
    template = """# elt        lat     z       ielement  atwt
# alpha      b0      b1      b2        b3      alat    esub    asub
# t0         t1      t2      t3        rozero  ibar

'XX'     '{lat}'  {z}     {ielement} {atwt}
{alpha}     Xb0      Xb1     Xb2        Xb3     {alat}  {esub}  Xasub
1.0         Xt1      Xt2     Xt3        {rozero} {ibar}
"""

    # Format the text with the extracted values
    formatted_text = template.format(
        #elt=element,
        lat=values["lat"],
        z=values["z"],
        ielement=values["ielement"],
        atwt=values["atwt"],
        alpha=values["alpha"],
        #b0=values["b0"],
        #b1=values["b1"],
        #b2=values["b2"],
        #b3=values["b3"],
        alat=values["alat"],
        esub=values["esub"],
        asub=values["asub"],
        #t0=values["t0"],
        #t1=values["t1"],
        #t2=values["t2"],
        #t3=values["t3"],
        rozero=values["rozero"],
        ibar=values["ibar"]
    )

    # Write the formatted text to the MEAM file
    with open("library_template.meam", "w") as output_file:
        output_file.write(formatted_text)

    print(f"library_template.meam has been created for element: {element}.")
else:
    print(f"Error: '{element}' not found in library.json.")

#----------------------------------------------------------
# Load the JSON file
with open("library.json", "r") as file:
    data = json.load(file)

# Check if the specified element exists in the data
if element in data:
    values = data[element]

    # Define the MEAM file format
    template = """# 2NN-MEAM
rc = 5.5          # default = 4.0 (4.7 <= K >= 5.9, Rb >= 5.1, CHGNET:6.0)
delr = 0.1        # default = 0.1
augt1 = 1         # default = 1
ialloy = 0        # default = 0
emb_lin_neg = 0   # default = 0
bkgd_dyn = 0      # default = 0
erose_form = 2    # default = 0, In 1NN-MEAM, d=a3=0, so erose_form will give the same result for 0-2.
mixture_ref_t = 0 # default = 0

### When parameters are fitted using DYNAMO code.
# ialloy = 0 # 0 or 1
# emb_lin_neg = 1
# bkgd_dyn = 1

# XX
zbl(1,1) = 0
nn2(1,1) = 1
repuls(1,1) = {repuls11}
attrac(1,1) = {attrac11}
Cmin(1,1,1) = XCmin
Cmax(1,1,1) = XCmax
"""

    # Format the text with the extracted values
    formatted_text = template.format(
        repuls11=values["repuls(1,1)"],
        attrac11=values["attrac(1,1)"],
        Cmin111=values["Cmin(1,1,1)"],
        Cmax111=values["Cmax(1,1,1)"],
    )

    # Write the formatted text to the MEAM file
    with open("XX_template.meam", "w") as output_file:
        output_file.write(formatted_text)

    print(f"XX_template.meam has been created for element: {element}.")
else:
    print(f"Error: '{element}' not found in library.json.")
