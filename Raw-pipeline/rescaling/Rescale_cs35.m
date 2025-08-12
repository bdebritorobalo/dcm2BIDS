% 01-06-2022
% Anne Leenders
% Uses FSL flirt to rescale the T1 scans to 1x1x1 mm

%% User input
%opy_folder = '/Users/anneleenders/HPC13/MRIdata/PMCLAB2019.084/Ttest';
copy_folder = '/Users/anneleenders/HPC12/MRIdata/PMCLAB2019.084/BRAIN_ONLY_BIDS';
%derivatives_folder = '/Users/anneleenders/HPC13/MRIdata/PMCLAB2019.084/Ttest/derivatives';
derivatives_folder = '/Users/anneleenders/HPC12/MRIdata/PMCLAB2019.084/BRAIN_ONLY_BIDS/derivatives';

reference = '/usr/local/fsl/data/standard/MNI152_T1_1mm.nii.gz';

%% Code to rescale the 1.5T and 3T T1 MRI data and store the output in a derivatives folder such that it is in the correct structure for Longitudinal CAT12.

% Read all folders that start with sub
subs = dir(fullfile(copy_folder, '*sub-0016*'));
subs_names = {subs.name}'; %names only

% Read all sessions in each subjects folder
for i=1:length(subs_names)
    mkdir(fullfile(derivatives_folder, subs_names{i})); %create subject folder for every subject in the derivatives folder.

    ses = dir(fullfile(copy_folder, subs_names{i}, '*ses-mri001*'));
    ses_names={ses.name}; %names only

    %Find T1 image that needs to be rescaled
    for k=1:length(ses_names)

        filename_to_rescale_15 = dir(fullfile(copy_folder, subs_names{i}, ses_names{k}, 'anat', '*s_3D_T1W_cs_2*.nii')); %full name of the 1.5T file that needs to be rescaled.
        if ~isempty(filename_to_rescale_15)
            rescale_15_names={filename_to_rescale_15.name}; %keep names only for 1.5T files to be rescaled

            temp_rescale_15_names = rescale_15_names{1};

            full_name_input_15 = fullfile(copy_folder, subs_names{i}, ses_names{k}, 'anat', temp_rescale_15_names);
            full_name_output_15 = fullfile(derivatives_folder, subs_names{i}, [temp_rescale_15_names(1:end-7) '_rescale_1x1x1.nii']);
            xcmd_15 = ['flirt -in ' full_name_input_15 ' -ref ' reference ' -applyisoxfm 1.0 -nosearch -out ' full_name_output_15]; %reference is specified in the user input section
            disp(full_name_input_15); disp(full_name_output_15);
            [status,result] = system(xcmd_15); %copy with Linux cp, matlab is too slow.
        end

        filename_to_rescale_3 = dir(fullfile(copy_folder, subs_names{i}, ses_names{k}, 'anat', '*s_T1_3D_TFE_cs*.nii')); %full name of the 3T file that needs to be rescaled.

        if ~isempty(filename_to_rescale_3)

            rescale_3_names={filename_to_rescale_3.name}; %keep names only for 3T files to be rescaled

            temp_rescale_3_names = rescale_3_names{1};

            full_name_input_3 = fullfile(copy_folder, subs_names{i}, ses_names{k}, 'anat', temp_rescale_3_names);
            full_name_output_3 = fullfile(derivatives_folder, subs_names{i}, [temp_rescale_3_names(1:end-7) '_rescale_1x1x1.nii']);
            xcmd_3 = ['flirt -in ' full_name_input_3 ' -ref ' reference ' -applyisoxfm 1.0 -nosearch -out ' full_name_output_3]; %reference is specified in the user input section
            disp(full_name_input_3); disp(full_name_output_3);
            [status,result] = system(xcmd_3); %copy with Linux cp, matlab is too slow.
        end

    end
end

