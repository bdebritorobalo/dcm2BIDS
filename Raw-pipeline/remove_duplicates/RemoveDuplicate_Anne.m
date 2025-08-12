% 06-04-2022
% Bruno Robalo
% Maps names of the folders to corresponding PMCRAD and PMCID based on
% Koppellijst file. e.g., Anonymous_Female_2006_2237309 --> will be mapped
% to 20181012-PMCRA954AAE-PMC_MRI_HERSENEN

%% copy Part 2 into the download folder
copy_folder = '/Users/anneleenders/HPC13/MRIdata/PMCLAB2019.084/AA_Rest_BRAIN_ONLY_BIDS';

% Read all anonymous folders
subs = dir(fullfile(copy_folder, 'sub-*')); %read all folders that start with Anonymous
subs_names = {subs.name}'; %names only

for i=1:length(subs_names)
    ses = dir(fullfile(copy_folder, subs_names{i}, 'ses-*')); %read all PMCRAD in each anonymous folder


    ses_names={ses.name}; %keep names only for PMCRAD folders
    for k=1:length(ses_names)
        name_of_file_move = dir(fullfile(copy_folder, subs_names{i}, ses_names{k}, 'anat', '*a.*')); % full name of the folder that needs to be coppied with contents.
        mkdir(fullfile(copy_folder, subs_names{i}, ses_names{k},'anat','duplicates'));
        duplicate_folder = fullfile(copy_folder, subs_names{i}, ses_names{k},'anat','duplicates');


        if ~isempty(name_of_file_move)
            aa_names={name_of_file_move.name}'; %keep names only for aa duplicates

            for n=1:length(aa_names)
                full_name_a_file_move = fullfile(copy_folder, subs_names{i}, ses_names{k}, 'anat', aa_names{n});
                xcmd = ['mv ' full_name_a_file_move ' ' duplicate_folder];

                disp(full_name_a_file_move); disp(duplicate_folder);
                [status,result] = system(xcmd); %copy with Linux cp, matlab is too slow.





            end
        end
    end
end




%
%
%
%             end
%
%             if ~isfolder(fullfile(paste_folder, subs_names{i}, ses_names{k})) %check if a folder with that PMCRAD
%                 mkdir((fullfile(paste_folder, subs_names{i}, ses_names{k}))) % if not make a folder with that name
%
%             end
%
%             copy_folder_name = fullfile(copy_folder, subs_names{i}, ses_names{k}, '*');
%             paste_folder_name = fullfile(paste_folder, subs_names{i}, ses_names{k});
%             xcmd = ['cp -r ' copy_folder_name ' ' paste_folder_name];
%             disp(copy_folder_name); disp(paste_folder_name);
%            [status,result] = system(xcmd); %copy with Linux cp, matlab is too slow.
%
%
%
%
%         end
%
%
%     end
%
%
% end
