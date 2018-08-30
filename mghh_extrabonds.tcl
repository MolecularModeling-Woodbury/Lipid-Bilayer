# Make extrabond file for MGHH stability
# Usage: tclsh mghh_extrabonds.tcl pdbFile extrabondFile
# Author: Chen-Yu Li <cli56@illinois.edu> 
# 2015/5/19

set pattern {ATOM  .{5}.(.{4})..{3}...{4}.....{8}.{8}.{8}.{6}.{6}.{6}.{4}}

set count 0

#This line sets the variable "inFile" which is the pdb file passed upon execution of this script in shell
#open opens the file with read-only priveledges. 
#I'm not sure why lindex is used but it retreieves an element from the list $argv which is the filename passed upon execution
#and 0 says to return the "first element"
set inFile [open [lindex $argv 0] r]

#I'm not sure why the outfile is commented out to not be used?
#set outFile [open [lindex $argv 1] w]

#beginning of the command to search my inFile
#foreach line means to search the file in each line using the following commands
#split means to take the inFile and split each new line "\n" for processing
foreach line [split [read $inFile] \n] {

#if pattern matches the line incr count. In other words skip the line and go to the next one.
    if {[regexp $pattern $line matched name]} {

        incr count

        if {[regexp {MG} $name matched]} {

            puts [format "bond %8d %8d %8.3f %8.3f" [expr $count-1] $count 10 1.94]
            puts [format "bond %8d %8d %8.3f %8.3f" [expr $count-1] [expr $count + 3]  10 1.94]
            puts [format "bond %8d %8d %8.3f %8.3f" [expr $count-1] [expr $count + 6]  10 1.94]
            puts [format "bond %8d %8d %8.3f %8.3f" [expr $count-1] [expr $count + 9]  10 1.94]
            puts [format "bond %8d %8d %8.3f %8.3f" [expr $count-1] [expr $count + 12] 10 1.94]
            puts [format "bond %8d %8d %8.3f %8.3f" [expr $count-1] [expr $count + 15] 10 1.94]
        }


    }
}

close $inFile
#close $outFile


