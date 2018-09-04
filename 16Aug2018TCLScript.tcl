#My TCL script that will take two bilayer membrane systems and combine them together.
# Robert Coffman 16 August 2018
#These commands can be visually inspected in the OpenGL window of VMD as they happen
#also it is good to verify that the selections are working correctly by verifying the atom count for each selection

#Alter these paths to the directories where your topology files and systems.
set var3 {C:\Users\Robert\Desktop\namd15\DiheTest\toppar}
set var45 {C:\Users\Robert\Desktop\namd15\DiheTest\0.15MKCl87LipidSystem\step5_assembly}
set var46 {C:\Users\Robert\Desktop\namd15\DiheTest\2MKCl90LipidSystem\step5_assembly}

#Do not alter these unless you know which parameter or topology file you don't want VMD to use.
set var4 "${var3}\\par_all36m_prot.prm"
set var5 "${var3}\\par_all36_na.prm"
set var6 "${var3}\\par_all36_carb.prm"
set var7 "${var3}\\par_all36_lipid.prm"
set var8 "${var3}\\par_all36_cgenff.prm"
set var9 "${var3}\\toppar_water_ions.str"
set var10 "${var3}\\toppar_dum_noble_gases.str"
set var11 "${var3}\\toppar_all36_prot_d_aminoacids.str"
set var12 "${var3}\\toppar_all36_prot_fluoro_alkanes.str"
set var13 "${var3}\\toppar_all36_prot_heme.str"
set var14 "${var3}\\toppar_all36_prot_na_combined.str"
set var15 "${var3}\\toppar_all36_prot_retinol.str"
set var16 "${var3}\\toppar_all36_na_nad_ppi.str"
set var17 "${var3}\\toppar_all36_na_rna_modified.str"
set var18 "${var3}\\toppar_all36_lipid_bacterial.str"
set var19 "${var3}\\toppar_all36_lipid_cardiolipin.str"
set var20 "${var3}\\toppar_all36_lipid_cholesterol.str"
set var21 "${var3}\\toppar_all36_lipid_inositol.str"
set var22 "${var3}\\toppar_all36_lipid_lps.str"
set var23 "${var3}\\toppar_all36_lipid_miscellaneous.str"
set var24 "${var3}\\toppar_all36_lipid_model.str"
set var25 "${var3}\\toppar_all36_lipid_prot.str"
set var26 "${var3}\\toppar_all36_lipid_pyrophosphate.str"
set var27 "${var3}\\toppar_all36_lipid_sphingo.str"
set var28 "${var3}\\toppar_all36_lipid_yeast.str"
set var29 "${var3}\\toppar_all36_lipid_hmmm.str"
set var30 "${var3}\\toppar_all36_lipid_detergent.str"
set var31 "${var3}\\toppar_all36_carb_glycolipid.str"
set var32 "${var3}\\toppar_all36_carb_glycopeptide.str"
set var33 "${var3}\\toppar_all36_carb_imlab.str"
set var34 "${var3}\\toppar_all36_label_spin.str"
set var35 "${var3}\\toppar_all36_label_fluorophore.str"




#load the system with the psf in to VMD and psfgen
resetpsf
readpsf ${var45}.xplor_ext.psf
coordpdb ${var45}.namd.pdb
mol load psf ${var45}.xplor_ext.psf pdb ${var45}.namd.pdb 
set sel12 [molinfo top get id]

#select each half of the system and save the selections to the variables sel and sel2
set sel [atomselect $sel12 "same residue as z<-8"]
set sel2 [atomselect $sel12 "same residue as z>8"]

#Move each half of the system 43 angstroms in opposite directions to make space for the second system
$sel moveby {0 0 -43}
$sel2 moveby {0 0 43}

#delete the selections to save memory
$sel delete
$sel2 delete

# select all of the waters and rename them to WATC
set sel3 [atomselect $sel12 "water"]
$sel3 set segname WATC
$sel3 delete

#prepare psfgen
package require psfgen
topology ${var4}
topology ${var5}
topology ${var6}
topology ${var7}
topology ${var8}
topology ${var9}
topology ${var10}
topology ${var11}
topology ${var12}
topology ${var13}
topology ${var14}
topology ${var15}
topology ${var16}
topology ${var17}
topology ${var18}
topology ${var19}
topology ${var20}
topology ${var21}
topology ${var22}
topology ${var23}
topology ${var24}
topology ${var25}
topology ${var26}
topology ${var27}
topology ${var28}
topology ${var29}
topology ${var30}
topology ${var31}
topology ${var32}
topology ${var33}
topology ${var34}
topology ${var35}

#write the new pdb and psf before the new system is read in
set sel4 [atomselect $sel12 "all"]
${sel4} writepdb separatedBilayer.pdb
${sel4} writepsf separatedBilayer.psf
$sel4 delete


#read in the new system to VMD and psfgen
resetpsf
readpsf ${var46}.xplor_ext.psf
coordpdb ${var46}.namd.pdb
mol load psf ${var46}.xplor_ext.psf pdb ${var46}.namd.pdb 
set sel13 [molinfo top get id]

#select each half of the second system to be moved
set sel5 [atomselect $sel13 "same residue as z<-8"]
set sel6 [atomselect $sel13 "same residue as z>8"] 

#Now move the two halves of the second system
$sel5 moveby {0 0 42}
$sel6 moveby {0 0 -42}
$sel5 delete
$sel6 delete

# select all of the waters of 2nd system and rename them to WATB
set sel7 [atomselect $sel13 "water"]
$sel7 set segname WATB
$sel7 delete

#prepare psfgen
package require psfgen
topology ${var4}
topology ${var5}
topology ${var6}
topology ${var7}
topology ${var8}
topology ${var9}
topology ${var10}
topology ${var11}
topology ${var12}
topology ${var13}
topology ${var14}
topology ${var15}
topology ${var16}
topology ${var17}
topology ${var18}
topology ${var19}
topology ${var20}
topology ${var21}
topology ${var22}
topology ${var23}
topology ${var24}
topology ${var25}
topology ${var26}
topology ${var27}
topology ${var28}
topology ${var29}
topology ${var30}
topology ${var31}
topology ${var32}
topology ${var33}
topology ${var34}
topology ${var35}


#write the new pdb and psf of the second system
set sel8 [atomselect $sel13 "all"]
${sel8} writepdb switchedBilayer.pdb
${sel8} writepsf switchedBilayer.psf
$sel8 delete

#select all of both systems and combine them in to one system using topotools
set sel6 [atomselect $sel12 {all}] 
set sel7 [atomselect $sel13 {all}] 
package require topotools 
set mol3 [::TopoTools::selections2mol "$sel6 $sel7"] 

set sel9 [atomselect $mol3 "lipid and z>0"]
$sel9 set segname MEMB
$sel9 delete
set sel10 [atomselect $mol3 "lipid and z<0"]
$sel10 set segname MEMA
$sel10 delete

#write the new pdb and psf of the combined system
set sel11 [atomselect $mol3 "all"]
resetpsf
$sel11 writepdb merged.pdb
$sel11 writepsf merged.psf

return