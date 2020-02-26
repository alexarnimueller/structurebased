#! /usr/bin/env python

import sys
from rdkit.Chem import SDMolSupplier, MolToPDBFile, AllChem, AddHs, RemoveHs
from rdkit.Chem.Draw import MolsToGridImage

spl = SDMolSupplier(sys.argv[1])
mols = [m for m in spl]

for i, m in enumerate(mols):
    m = AddHs(m)
    AllChem.EmbedMolecule(m, useBasicKnowledge=True, maxAttempts=100)
    AllChem.MMFFOptimizeMolecule(m)
    RemoveHs(m)
    MolToPDBFile(m, 'ligand_%d.pdb' % i)

img = MolsToGridImage(mols, legends=["ligand_%d" % i for i in range(len(mols))])
img.save('ligands.png')

