%%  Map folder name RADs to PMC IDS
copy_folder = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/BRAIN_ONLY'; 
% paste_folder = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/BRAIN_ONLY_dicom';
koppel = readtable('/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/Koppellijst_excel.xlsx');
koppel.Var1 = num2cell(koppel.Var1);
% Read all pmcids folders 
pmcid = dir(fullfile(copy_folder, 'PMCID*')); %read all folders that start with Anonymous
pmcids_names = {pmcid.name}'; %names only



for i=1:length(pmcids_names)
    RADs = dir(fullfile(copy_folder, pmcids_names{i}, '*PMCRA*')); %read all PMCRAD in each anonymous folder
    disp(['PMC ID:' pmcids_names{i}])
    cd(fullfile(copy_folder, pmcids_names{i}))

    %now copy each PMCRAD and change their names    
    for j=1:length({RADs.name})
        RAD1_name = RADs(j).name;
        disp(['PMC RAD:' RAD1_name])

        % Find the sub/ses number that corresponds on that PMCRAD
        k2 = find(contains(koppel.Var3, RAD1_name));
        ses_nr = koppel.Var9(k2); %session number
        sub_nr = koppel.Var8(k2); %subject number

        prefix_sub=num2str(sub_nr);
        prefix_ses=num2str(ses_nr);

        %check how many characters session and subject number have
        if length(prefix_sub)==1
            final_prefix_sub = ['000' prefix_sub];
        elseif length(prefix_sub)==2
            final_prefix_sub = ['00' prefix_sub];
        elseif length(prefix_sub)==3
            final_prefix_sub = ['0' prefix_sub];
        else
            final_prefix_sub = prefix_sub;
        end

        if length(prefix_ses)==1
            final_prefix_ses = ['00' prefix_ses];
        elseif length(prefix_ses)==2
            final_prefix_ses = ['0' prefix_ses];
        else
            final_prefix_ses = ['0' prefix_ses];
        end

        %create new folder  names to rename the RAD IDs     
        old_ses_dir_name = fullfile(copy_folder, pmcids_names{i}, RAD1_name);
        new_ses_dir_name = fullfile(copy_folder, pmcids_names{i}, ['ses-mri' final_prefix_ses]);

        xcmd_rename_ses = ['mv ' old_ses_dir_name ' ' new_ses_dir_name]; %rename all session names first
        [status,result] = system(xcmd_rename_ses); %matlab's mv is too slow :(
    end 

    %now rename sub name
    old_sub_dir_name = fullfile(copy_folder, pmcids_names{i}); 
    new_sub_dir_name = fullfile(copy_folder, ['sub-' final_prefix_sub]);

    xcmd_rename_sub = ['mv ' old_sub_dir_name ' ' new_sub_dir_name]; %rename all session names first
    [status,result] = system(xcmd_rename_sub); %matlab's mv is too slow :(

end

