#! /bin/bash

# USAGE:
# 0) prepare your receptor and conf.txt file with the Vina plugin in PyMol
# 1) paste a file called "ligands.sdf" containing all your ligands into this folder
# 2) run "bash vina_multiligand_screen.sh"
# 3) inspect the results, for every ligand individually in one folder

# set path for autodock tools
adt=/home/endogena/Documents/Internal/IT/Code/Pymol-script-repo/modules/ADT
export PYTHONPATH=$PYTHONPATH:$adt

# prepare one pdb file for every ligand in the ligands.sdf file
/home/endogena/anaconda3/envs/pymol/bin/python prepare_ligands.py ligands.sdf

# run the docking procedure for every ligand and save the results in an individual folder
touch runlog.txt
echo "ligand      mode    affinity    rmsd-l.b.   rmsd-u.b." > runlog.txt

for f in ligand_*.pdb; do
    b=${f%.pdb}
    echo Processing ligand $b
    mkdir -p results/$b
    $adt/AutoDockTools/Utilities24/prepare_ligand4.py -l $f -o results/$b/$b.pdbqt
    vina --config conf.txt --ligand results/$b/$b.pdbqt --out results/$b/docked.pdbqt --log results/$b/log.txt
    mv $f results/$b/$f
    tail -n 10 $b/log.txt | head -n 9 | awk -v b=$b '{print b,$0}' >> runlog.txt
done

mv runlog.txt energies.txt
sed -i -e 's/  */\t/g' energies.txt

