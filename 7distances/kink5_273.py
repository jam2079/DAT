p=io.IOProfile(dialect='CHARMM',fault_tolerant=True)
#input_dir='...'
#Load protein
eh=io.LoadPDB(os.path.join('protein/prot.pdb'),profile=p)
#load trajectory
t=io.LoadCHARMMTraj(eh,os.path.join('protein/prot.dcd'))

#Select the helix you want to do the analysis on
sele=eh.Select('cname=PROT and rnum=266:280')
#select the proline. You don't actually have to, 
#he will find it automatically if you don't give it in
#proline=eh.Select('cname=PROT and rnum=25')
#(bend,shift,wobble)=mol.alg.helix_kinks.AnalyzeHelixKink(t,sele,proline)
(bend,shift,wobble)=mol.alg.helix_kinks.AnalyzeHelixKink(t,sele)
"""
#make plot
import matplotlib as mpl
mpl.use('Agg') #use plotting without xwindow
import matplotlib.pyplot as plt
plt.figure()
plt.plot(bend)
plt.show()
plt.savefig('bend5.png')
"""
#Write out file
sys.path.append('/home/nij2003/python_modules')
import file_utilities
file_utilities.WriteFloatList(bend,'bend5_273.txt')
