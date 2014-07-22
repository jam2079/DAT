p=io.IOProfile(dialect='CHARMM',fault_tolerant=True)
#input_dir='...'
#Load protein
eh=io.LoadPDB(os.path.join('protein/prot.pdb'),profile=p)
#load trajectory
t=io.LoadCHARMMTraj(eh,os.path.join('protein/prot.dcd'))

#Select the helix you want to do the analysis on
sele=eh.Select('cname=PROT and rnum=404:436 and aname=CA')
print sele,sele.IsValid()
for i,a in enumerate(sele.atoms[7:-7]):
  proline=mol.CreateViewFromAtoms([a.handle])
  al2=mol.AtomHandleList([a2.handle for a2 in sele.atoms[i:i+15]])
  sele2=mol.CreateViewFromAtoms(al2)
  print sele2.IsValid(),proline.IsValid()
  (bend,shift,wobble)=mol.alg.helix_kinks.AnalyzeHelixKink(t,sele2,proline)
  """
  #sele=eh.Select('cname=PROT and rnum=404:436')
  #select the proline. You don't actually have to,
  #he will find it automatically if you don't give it in
  #here=eh.Select('cname=PROT and rnum=420')
  #(bend,shift,wobble)=mol.alg.helix_kinks.AnalyzeHelixKink(t,sele,here)
  #(bend,shift,wobble)=mol.alg.helix_kinks.AnalyzeHelixKink(t,sele)

  #make plot
  import matplotlib as mpl
  mpl.use('Agg') #use plotting without xwindow
  import matplotlib.pyplot as plt
  plt.figure()
  plt.plot(bend)
  plt.show()
  #plt.savefig('bend8.png')
  """
  #Write out file
  sys.path.append('/home/nij2003/python_modules')
  import file_utilities
  file_utilities.WriteFloatList(bend,'bend8_'+str(a.residue.number.num)+'.txt')
