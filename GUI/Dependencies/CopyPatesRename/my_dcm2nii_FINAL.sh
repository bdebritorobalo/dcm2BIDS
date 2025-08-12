#!/bin/sh

#PATH=~/home/pmc_research/bdebritorobalo:$PATH

input_dir="/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/BRAIN_ONLY"
out_dir="/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/BRAIN_ONLY_nii"

i=0
cd $input_dir
for filename in sub* ; do

   subname=$input_dir/$filename
   echo $subname
   mkdir $out_dir/$filename #make subject folder in out dir

## Run only untill subject x -  break the loop
  echo "Number: $i"
  ((i++))
  if [[ "$i" == 'NaN' ]]; then
    break
  fi

#-------------read sessions----######
   for sesname in $input_dir/$filename/ses* ; do
      sesdir=$out_dir/$filename/${sesname: -10}
      dicom_dir=$input_dir/$filename/${sesname: -10}
      echo $sesdir
      mkdir $sesdir

      dcm2niix  -f %p_%t -o $sesdir $dicom_dir    #run dcm2nii
     #/home/pmc_research/bdebritorobalo/dcm2niix  -f %p_%t -o /hpc/shared/pmc_npsy/MRIProjects/LimbicSystem/TempProcessing /hpc/shared/pmc_npsy/MRIProjects/LimbicSystem/sourcedata/sub-0008/ses-mri002/401   
      echo $dicom_dir
      #unzip    -o $dicom_dir/*.zip    -d $dicom_dir
      done 
done






