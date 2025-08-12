#!/bin/sh


input_dir="/Volumes/pmc_mpartanen/MRIdata/SuSPeCT_Diffusion/Brain_dicom"
out_dir="/Volumes/pmc_mpartanen/MRIdata/SuSPeCT_Diffusion/Brain_nii"

i=0
cd $input_dir
for filename in sub-003* ; do

   subname=$input_dir/$filename
   echo $subname
   mkdir $out_dir/$filename 


  echo "Number: $i"
  ((i++))
  if [[ "$i" == 'NaN' ]]; then
    break
  fi


   for sesname in $input_dir/$filename/ses* ; do
      sesdir=$out_dir/$filename/${sesname: -10}
      dicom_dir=$input_dir/$filename/${sesname: -10}
      echo $sesdir
      mkdir $sesdir

      dcm2niix  -f %p_%t -o $sesdir $dicom_dir    

      echo $dicom_dir
  
      done 
done






