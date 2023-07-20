"""
The dataset is provided as a pandas pckl file which can be read in python using pandas.
The pckl was generated using pandas==1.4.3

The pckl file can be fitted directly to reproduce the potential with the pacemaker input script provided `fit_c_ACE.yaml`

In case of pandas compatibility issues, an extended xyz file can also be obtained by contacting Minaam Qamar: minaam.qamar@ruhr-uni-bochum.de
"""


import pandas as pd

df_training = pd.read_pickle("C_dataset.pckl.gzip",compression="gzip")
print(df_training.head())
