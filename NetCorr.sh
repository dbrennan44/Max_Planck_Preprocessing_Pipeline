#!/bin/bash

#output timeseries averaged Harvard-Oxford Atlas ROI's. Out form is [X1,Y1,Z1, t1,t2,t3,t4...tn].
while read subj
do 
for a in 1 2
do 
for b in 1 2
do

3dTstat -prefix _mean -mean temp_NL/${subj}_S${a}_R${b}_NL.ricor.results/errts.${subj}_S${a}_R${b}_NL.ricor.tproject+tlrc.
3dcalc -a _mean+tlrc. -expr 'step(a)' -prefix _NEWMASK 

3dNetCorr -inset temp_NL/${subj}_S${a}_R${b}_NL.ricor.results/errts.${subj}_S${a}_R${b}_NL.ricor.tproject+tlrc. \
-in_rois HO_atlas_resample+tlrc. -mask _NEWMASK+tlrc -prefix rest_corr_${subj}_${a}_${b}
rm _mean+tlrc*
rm _NEWMASK+tlrc*

done
done
done < subs.txt
