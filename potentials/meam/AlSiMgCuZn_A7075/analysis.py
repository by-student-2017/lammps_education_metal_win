# Appendix F. Python code for automatic analyses
import os;
import shutil;
for i in range(2):
  if i==0:
    dirname="7075"
  else:
    dirname="7075-zn"
  for j in range(4):
    stress=[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]
    strain=[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]
    stressr=[]
    strainr=[]
    if j==0:
      srate="1E8"
    elif j==1:
      srate="5E7"
    elif j==2:
      srate="1E9"
    elif j==3:
      srate="5E8"
    for k in range(5):
      l=k
      ll=str(l+1)
      ln=[]
      if os.path.isdir("./"+dirname+"/"+srate+"/"+ll+"/"+"deform"):
        f=open(dirname+"/"+srate+"/"+ll+"/"+"deform/mg001.defo.txt",'r')
        f.readline()
        for line in f:
          ln.append(line.split())
        for t in range(len(ln)):
          strain[k].append(ln[t][0])
          stress[k].append(ln[t][3])
        stressr.append(stress[k])
        strainr.append(strain[k])
        f.close()
    g=open(dirname+"-"+srate,'w')
    max=0
    for y in range(len(strainr)):
      if len(strainr[y])>max:
        max=len(strainr[y])
    for x in range(len(strainr)):
      if len(strainr[x])!=max:
        for e in range(max-len(strainr[x])):
          strainr[x].append('O')
          stressr[x].append('O')
    for n in range(max):
      g.write(strainr[0][n]+"\t")
      for q in range(len(stressr)):
        g.write(stressr[q][n]+"\t")
      g.write("\n")
    g.close()
