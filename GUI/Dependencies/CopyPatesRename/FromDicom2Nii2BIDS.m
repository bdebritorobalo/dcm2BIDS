% % 08-02-2022 
% Bruno Robalo, PMC 
% 
% This script organizes MRI DICOM data received from bdac commeettee to
% nifti and json files in  BIDS-like structure. Initially the data should
% be in 
% 
% 
% Step 1: Before downloading the data 
%     1. Connect to Isilon (ask Research IT): smb://t1s.gv.storageidt.prinsesmaximacentrum.nl/pmc_mpartanen
% 
% Step 2:  Downloading the data
%     1. Request Bdac Commeetee: 
%     2. Provide them the biobank approval and PMCIDS/PMCRADs 
%     3. When the data is available on RiA, you can download it there 
%     4. Download directly to Isilon on a new project folder: <Isilon mount>/MRIdata/<create a folder with PMC biobank approval number, e.g. PMCLAB2019.084>
%     5. After downloading, remove the data from RiA. 
%     6. Together with the MRI you should receive a "koppellijst.csv" that couples the PMCIDS with the PMCRADS and has the MRI sessions and information about the sessions. (save this file)
% 
% 
% Step 3: Unzipping and coppying
%     1. Unzip all folders (can be done recursively)
%     2. After Unzipping --> Rename all the subject folders to their corresponding PMCIDs and PMCRADs on koppellijst -> **write a script for it.** -->COMBINE WITH THE NEXT STEP
%     3. **Run a script (matlab or excel macro) to create the sub and ses naming for the bids structure in the full koppellijst file.--> SORT individual base on alphabetical order and sessions (within each id) based on examination date**
%     4. Rename the folder structure to sub-00xx/ses-mri00x **Move all the dcm series one folder up**
%     6. Convert dcm2niix *--> results end up in **temporary raw_nii**
%     7. Convert to BIDS **name the folder to somethig that makes sense, because this becomes the new raw data**
%     6. From the koppellijst select only the rows that you need (e.g., based on examination date, field strength, or scanned body part).
%     7. Copy only the data that you need (sub-00xx/ses-mri00x) to a project folder --> <Isilon mount>/MRIProject/<Project name>
%     8. From this point, data can be coppied to computing serves for r analysis. 
%     
