% 09-12-2021 
% Bruno & Anne
% When receiving MRI data, storing it on Isilon and after unzipping, this
% script can be run to move the sessions of the subjects to the folder of
% the project that the MRI analysis will be done with. 

% There has to be an excel file called sample.xlsx with the following
% variables: Name, PMCID and PMCRAD. This file has to be stored in the
% paste_folder.


% clear all; close all; clc;

%Folder on Isilon where the data is stored 
base_folder = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/download'; 

%Project folder on Isilon where the data has to be copied to. 
paste_folder = '/Volumes/pmc_mpartanen/MRIProjects/LimbicSystem';

sample = readtable('/Volumes/pmc_mpartanen/MRIProjects/LimbicSystem/sample.xlsx');
open sample;
names_only = sample.Name;
open names_only;

[~,unique_names]=unique(names_only, 'rows'); 
unique_names = names_only(unique_names, :);

PMCID_only = sample.PMCID;

[~,unique_PMCID]=unique(PMCID_only, 'rows'); 
unique_PMCID = PMCID_only(unique_PMCID, :);

PMCRAD = sample.PMCRAD;

for i =1:length(unique_names)
    folder_name = fullfile(base_folder, unique_names{i});
    cd (folder_name)

    for j = 1:length(PMCRAD)
       check = dir(['*' PMCRAD{j} '*']); %look for all desired PMCRAD within the anonym folder

       if ~isempty(check) %check if it finds any
           for k=1:size(check,1)%scroll throug all options 
               if check(k).isdir==1 %check if it's a directory or zip 
                   %Only copy if it's a directory
                   copy_folder_name = fullfile(base_folder, unique_names{i}, check(k).name);
                   mkdir(paste_folder, [PMCID_only{i}, '/', PMCRAD{j}]);
                   paste_folder_name = fullfile(paste_folder, unique_names{i}, PMCRAD{j});
                   disp(unique_names{i}); 
                   copyfile(copy_folder_name, paste_folder_name); %copies contents of folder 1 to folder 2
               end
           end
           movefile(fullfile(paste_folder, unique_names{i}), fullfile(paste_folder, unique_PMCID{i})) 
       end
    end   
end
