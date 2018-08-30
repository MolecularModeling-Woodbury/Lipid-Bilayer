# Lipid-Bilayer
Double lipid bilayer, osmotic gradient and alcohol.

membrane_lipid_restraint2.namd.str is to be used with:
toppar.str
step5_assembly.str
merged.psf
merged.crd

mghh_extrabonds are the same in pearl and tcl format. They use hextube_MGHH_WI.pdb. They are here because I was hoping to use them to create the dihe.txt file for use by NAMD colvars. But they are not understandable.

selectHead.tcl will be used to select the head groupd of this particular double lipid bilayer system. POPE and POPC are the lipids involved.
