# structurebased
Repository containing scripts for docking with Vina

## Prerequisites
- [Vina](http://vina.scripps.edu/) for docking
- [RDKit](https://github.com/rdkit/rdkit) for ligand conformer generation
- [Pymol](https://pymol.org/) with AutoDockTools / Vina plugin for receptor and ligand preparation

## Usage
1) Adapt to your paths to python and autodock tools in the file `vina_multiligand_screen.sh`
2) Prepare your receptor with the Vina plugin in PyMol and save the `receptor.pdbqt` file in this directory
3) Adapt the `conf.txt` file to fit the center and dimensions of the grid as well as the receptor file(s)
4) Put the ligands to be docked in a SD file called `ligands.sdf` in this directory (2D coordinates are enough)
5) run `bash vina_multiligand_screen.sh`

## Output
The script will generate the following:
- A grid image of the ligands in `ligands.png`
- A folder for every ligand containing the docking results
- A global `energies.txt` containing the energies for all docked conformations of the individual ligands
