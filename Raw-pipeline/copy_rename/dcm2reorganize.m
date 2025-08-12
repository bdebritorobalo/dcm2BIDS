% Use this script to move the unzipped DICOM series within each subject folders, one folder up.
% Before this scrip the data structure should be
% <DATAFOLDER>/subject/session(PMCRAD)/Unzipped_dicom_folder/<dicom
% series>(e.g., 1001, 201, 902, etc). These last folders will be moved
% directory up.
% give as input teh data folder with all the subjects.
% This script should be run before dcm to nifti convertion. (check,
% my_dcm2nii.sh)
% After dcm2reorganize.m, we can run OrganizeDataBidsLikeScript.m

dcm_folder='/Users/brunorobalo/Desktop/HPC33/pmc_npsy/MRIProjects/LimbicSystem/sourcedata'; %/hpc/shared/pmc_npsy/MRIProjects/LimbicSystem/sourcedata
nii_folder = '/Users/brunorobalo/Desktop/HPC33/pmc_npsy/MRIProjects/LimbicSystem/BIDSdata'; % /hpc/shared/pmc_npsy/MRIProjects/LimbicSystem/BIDSdata/
%
% dcm_folder= '/hpc/shared/pmc_npsy/MRIProjects/LimbicSystem/sourcedata';
% nii_folder = '/hpc/shared/pmc_npsy/MRIProjects/LimbicSystem/BIDSdata/';

mkdir(nii_folder);
cd(dcm_folder);
d=dir(dcm_folder);
% table1 = readtable('/Users/brunorobalo/Documents/DCM2BIDS/SampleList.xlsx');
% table1_PMCRAD = table1.radiology_id;
% table1_session = table1.ses_id_3T_entirebrain;
%
% table1_PMCID = table1.individual_id;
% table1_subidnr = table1.sub_id_3T_entirebrain;

ids = {d.name}';
ids = ids(~strncmp(ids, '.',1));


for i=2:3%i=1:length(ids)
    disp(ids{i})
    %Get into each subjects folder and check sessions
    pmcid = fullfile(dcm_folder, ids{i});
    session=dir(pmcid);
    ses = {session.name}';
    ses = ses(~strncmp(ses, '.',1));

    % -----------Change sub names (PMCIC) to sub-xxxxx----

    %     idx0 = find(contains(table1_PMCID,ids{i}(5:end))); %finds excell row where the session is; (5:end) because i added "sub-" before PMCIDS
    %     idNr = table1_subidnr(idx0(1)); idNr = sprintf( '%04d', idNr);
    %     new_id_name = fullfile(dcm_folder,  ['sub-' idNr]);
    %     disp(new_id_name)
    %     movefile(pmcid,new_id_name)

    % -----------END: Change sub names (PMCIC) to sub-xxxxx----


    %Check sessions and unzipped folder
    for j=1:length(ses)
        disp(ses{j})
        ses_folder = fullfile(dcm_folder, ids{i}, ses{j});
        uzp_folder = dir(ses_folder);
        uzp = {uzp_folder.name}';
        uzp = uzp(~strncmp(uzp, '.',1));

        %         activate_command='source activate /Users/brunorobalo/opt/miniconda3/envs/dcm2bids';
        %         [~,cmdout] = system(activate_command);

        dir_nii=fullfile(nii_folder, ids{i}, ses{j});
        %         mkdir(dir_nii);

        %         dcm2nii  = ['/Users/brunorobalo/opt/miniconda3/envs/dcm2bids/bin/dcm2niix  -f %p_%t -o ', dir_nii, ' ', ses_folder];
        %         [~,cmdout] = system(dcm2nii);


        %         --------------Move DCM one fodler up--------
        for k=1:length(uzp)
            if isfolder(fullfile(dcm_folder, ids{i}, ses{j}, uzp{k}))
                disp(fullfile(dcm_folder, ids{i}, ses{j}, uzp{k}));
                %
                command = ['mv ', fullfile(dcm_folder, ids{i}, ses{j}, uzp{k}, '*'),  ' ', fullfile(dcm_folder, ids{i}, ses{j})];
%                 [~,cmdout] = system(command)

                %                 movefile (fullfile(dcm_folder, ids{i}, ses{j}, uzp{k}, '*'), fullfile(dcm_folder, ids{i}, ses{j})); %move up
                %                 rmdir(fullfile(dcm_folder, ids{i}, ses{j}, uzp{k})) % delete
                %             end

            end

            %     --------------END Move DCM one fodler up--------


            % -----------Change session names (PMCRAD) to ses-mrx

            %         idx = find(contains(table1_PMCRAD,ses{j})); %finds excell row where the session is
            %         sesNr = table1_session(idx); sesNr = num2str(sesNr);
            %         new_ses_name = fullfile(dcm_folder, ids{i},  ['ses-mri00' sesNr]);
            %         disp(new_ses_name)

            %         movefile(ses_folder,new_ses_name)


        end
    end
end