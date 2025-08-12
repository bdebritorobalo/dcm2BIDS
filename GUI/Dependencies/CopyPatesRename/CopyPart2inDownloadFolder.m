% 06-04-2022
% Bruno Robalo
% Maps names of the folders to corresponding PMCRAD and PMCID based on
% Koppellijst file. e.g., Anonymous_Female_2006_2237309 --> will be mapped
% to 20181012-PMCRA954AAE-PMC_MRI_HERSENEN 

%% copy Part 2 into the download folder 
copy_folder = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/Part2/download'; 
paste_folder = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/download';

% Read all anonymous folders 
part2Anonym = dir(fullfile(copy_folder, 'Anonymous*')); %read all folders that start with Anonymous
part2Anonym_names = {part2Anonym.name}'; %names only

for i=1:length(part2Anonym_names)
    newRADs = dir(fullfile(copy_folder, part2Anonym_names{i}, '*PMCRA*')); %read all PMCRAD in each anonymous folder
    
    if ~isempty(newRADs) % if not empty 
        newRADs_names={newRADs.name}; %keep names only for PMCRAD folders 
        for k=1:length(newRADs_names)
            name_of_folder_copy = fullfile(copy_folder, part2Anonym_names{i}, newRADs_names{k}); % full name of the folder that needs to be coppied with contents. 
            if ~isfolder(fullfile(paste_folder, part2Anonym_names{i})) %check if a folder with that anonymous names already exists in the paste folder
                mkdir((fullfile(paste_folder, part2Anonym_names{i}))) % if not make a folder with that name
            end

            if ~isfolder(fullfile(paste_folder, part2Anonym_names{i}, newRADs_names{k})) %check if a folder with that PMCRAD
                mkdir((fullfile(paste_folder, part2Anonym_names{i}, newRADs_names{k}))) % if not make a folder with that name
                
            end

            copy_folder_name = fullfile(copy_folder, part2Anonym_names{i}, newRADs_names{k}, '*');
            paste_folder_name = fullfile(paste_folder, part2Anonym_names{i}, newRADs_names{k});
            xcmd = ['cp -r ' copy_folder_name ' ' paste_folder_name];
            disp(copy_folder_name); disp(paste_folder_name);
           [status,result] = system(xcmd); %copy with Linux cp, matlab is too slow. 




        end


    end


end
