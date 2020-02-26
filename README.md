# structurebased
Repository containing scripts for docking with Vina

## Prerequisites
- [Vina](http://vina.scripps.edu/) for docking
- [RDKit](https://github.com/rdkit/rdkit) for ligand conformer generation
- Pymol with AutoDockTools / Vina plugin for receptor and ligand preparation

## Usage
1) Prepare your receptor with the Vina plugin in PyMol and save the `receptor.pdbqt` file in this directory
2) Adapt the `conf.txt` file to fit the center and dimensions of the grid as well as the receptor file(s)
3) Put the ligands to be docked in a SD file called `ligands.sdf` in this directory (2D coordinates are enough)
4) run `bash vina_multiligand_screen.sh`

## Output
The script will generate the following:
- A grid image of the ligands in `ligands.png`
- A folder for every ligand containing the docking results
- A global `runlog.txt` containing the energies for all docked conformations of the individual ligands
