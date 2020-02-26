#! /bin/bash

# USAGE:
# 0) prepare your receptor and conf.txt file with the Vina plugin in PyMol
# 1) paste a file called "ligands.sdf" containing all your ligands into this folder
# 2) run "bash vina_multiligand_screen.sh"
# 3) inspect the results, for every ligand individually in one folder

# python path for autodock tools
export PYTHONPATH=$PYTHONPATH:/home/endogena/Documents/Internal/IT/Code/Pymol-script-repo/modules/ADT

# prepare one pdb file for every ligand in the ligands.sdf file
/home/endogena/anaconda3/envs/pymol/bin/python prepare_ligands.py ligands.sdf

# run the docking procedure for every ligand and save the results in an individual folder
touch runlog.txt
for f in ligand_*.pdb; do
    b=${f%.pdb}
    echo Processing ligand $b
    mkdir -p $b
    /home/endogena/Documents/Internal/IT/Code/Pymol-script-repo/modules/ADT/AutoDockTools/Utilities24/prepare_ligand4.py -l $f -o $b/$b.pdbqt
    vina --config conf.txt --ligand $b/$b.pdbqt --out $b/docked.pdbqt --log $b/log.txt
    mv $f $b/$f
    echo "----- ${b} -----" >> runlog.txt
    tail -n 6 $b/log.txt | head -n 5 >> runlog.txt
done
