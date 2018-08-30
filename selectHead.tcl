#This script was created on 30 Aug 2018 by Robert Coffman
#This is designed to select the head groups of POPE and POPC when there are two membranes
#with segnames of MEMA and MEMB
#The outputs will be used as references for restraining the head groups using colvars.


#Alter these paths to the directories where your topology and pdb/psf files are at.
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
readpsf ${var45}.psf
coordpdb ${var45}.pdb
mol load psf ${var45}.psf pdb ${var45}.pdb 
set sel12 [molinfo top get id]


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

#this selects the entire system for writing the new PDBs
set all [atomselect $sel12 "all"]

#atomselections for the head groups of POPE for the two different membranes
set head [atomselect $sel12 "{segid MEMB and resname POPE} and \
{name P or name N or name C11 or name C12 or name O11 or name O12 or name O13 or name O14} and z>0"]
$all set beta 0
$head set beta 1
$all writepdb membpopetophead.pdb
$head delete

set head [atomselect $sel12 "{segid MEMB and resname POPE} and \
{name P or name N or name C11 or name C12 or name O11 or name O12 or name O13 or name O14} and z<0"]
$all set beta 0
$head set beta 1
$all writepdb membpopebothead.pdb
$head delete

set head [atomselect $sel12 "{segid MEMA and resname POPE} and \
{name P or name N or name C11 or name C12 or name O11 or name O12 or name O13 or name O14} and z>0"]
$all set beta 0
$head set beta 1
$all writepdb memapopetophead.pdb
$head delete

set head [atomselect $sel12 "{segid MEMA and resname POPE} and \
{name P or name N or name C11 or name C12 or name O11 or name O12 or name O13 or name O14} and z<0"]
$all set beta 0
$head set beta 1
$all writepdb memapopebothead.pdb
$head delete

#atomselection for the head groups of the POPC for the two different membranes
set head [atomselect $sel12 "{segid MEMB and resname POPC} and \
{name P or name N or name C11 or name C12 or name C13 or name C14 or name C15\
or name O11 or name O12 or name O13 or name O14} and z>0"]
$all set beta 0
$head set beta 1
$all writepdb membpopctophead.pdb
$head delete

set head [atomselect $sel12 "{segid MEMB and resname POPC} and \
{name P or name N or name C11 or name C12 or name C13 or name C14 or name C15\
or name O11 or name O12 or name O13 or name O14} and z<0"]
$all set beta 0
$head set beta 1
$all writepdb membpopcbothead.pdb
$head delete

set head [atomselect $sel12 "{segid MEMA and resname POPC} and \
{name P or name N or name C11 or name C12 or name C13 or name C14 or name C15\
or name O11 or name O12 or name O13 or name O14} and z>0"]
$all set beta 0
$head set beta 1
$all writepdb memapopctophead.pdb
$head delete

set head [atomselect $sel12 "{segid MEMB and resname POPC} and \
{name P or name N or name C11 or name C12 or name C13 or name C14 or name C15\
or name O11 or name O12 or name O13 or name O14} and z<0"]
$all set beta 0
$head set beta 1
$all writepdb memapopcbothead.pdb
$head delete

return