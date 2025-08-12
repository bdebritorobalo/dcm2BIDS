% 06-04-2022
% Bruno Robalo
% Maps names of the folders to corresponding PMCRAD and PMCID based on
% Koppellijst file. e.g., Anonymous_Female_2006_2237309 --> will be mapped
% to 20181012-PMCRA954AAE-PMC_MRI_HERSENEN 

addpath(genpath('/Users/brunorobalo/Documents/MATLAB/spm12'));
addpath(genpath('/Volumes/pmc_mpartanen/MRIdata/Code/runCat12_batch'));

copy_folder = '/Users/brunorobalo/Desktop/HPC14/MRIdata/PMCLAB2019.084/BRAIN_ONLY_BIDS/derivatives_unzipped/derivatives/surf'; 
paste_folder = '/Users/brunorobalo/Desktop/HPC14/MRIProjects/PSR_Project/surf';
patient_selection = '/Users/brunorobalo/Desktop/HPC14/MRIProjects/PSR_Project/patient_selection_PSR.xlsx';

patients = readtable(patient_selection);
patient_sub_nr = patients.sub;
patient_ses_nr = patients.ses;


for i=1:length(patient_ses_nr)
    sub_ses_name_tag = ['*', patient_sub_nr{i}, '_', patient_ses_nr{i}, '*'];
    files_found = dir([copy_folder, '/' sub_ses_name_tag]); %read all PMCRAD in each anonymous folder
    
    if ~isempty(files_found) % if not empty 
        found_names={files_found.name}; %keep names only for PMCRAD folders 
        for k=1:length(found_names)
            copy_this_file_name = fullfile(copy_folder, found_names{k}); % full name of the file that needs to be coppied
            xcmd = ['cp ' copy_this_file_name ' ' paste_folder];
            disp(copy_this_file_name); 
           [status,result] = system(xcmd); %copy with Linux cp, matlab is too slow. 
        end
    end
end
