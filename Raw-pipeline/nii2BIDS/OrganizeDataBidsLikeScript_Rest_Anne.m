% This script will reorganize nii data into bids-like structure 
%the nifiti files shoudl be in this structure
% <DATAFOLDER>/subject/session/nii and json files 
%Resulting output should be in this structure:
% DATAFOLDER>/subject/session/anat;func;dwi 
% This script should be run after dcm2nii conversion 

output_root = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084';
addpath(genpath('/Volumes/pmc_mpartanen/MRIdata/Code/spm12'));
addpath(genpath('/Volumes/pmc_mpartanen/MRIdata/Code/MRIToolkit-master'));

global MRIToolkit;
if(isempty(which('spm_jsonread')))
    if(isfield(MRIToolkit,'JSONio') && exist(MRIToolkit.JSONio,'dir') > 0)
        addpath(MRIToolkit.JSONio);s
    else
        error('This function needs the JSONio library to properly work. Configure MRIToolkitDefineLocalVars.m accordingly.');
    end
end

TempDirectory = fullfile(output_root,'TempProcessing_Anne');
RawFolder = fullfile(output_root,'AA_BRAIN_ONLY_nii');
OutputFolder = fullfile(output_root,'AA_BRAIN_ONLY_BIDS');

if(exist(RawFolder,'dir') < 1)
    mkdir(RawFolder);
end

if(exist(OutputFolder,'dir') < 1)
    mkdir(OutputFolder);
end

if(exist(TempDirectory,'dir') < 1)
    mkdir(TempDirectory);
end

AcquisitionTypes = {};
% AcquisitionCategories = {
%     {'T1 3D','anat'},...
%     {'s 3D T2','anat'},...
%     {'s 3D_FLAIR','anat'},...
%     {'fmri','func'},...
%     {'bold','func'},...
%     {'t pCASL','func'},...
%     {'FE_EPI perfusie','func'},...
%     {'t DW_HR 3mm','dwi'},...
%     {'dti','dwi'},...
%     %     {'dmri','dwi'},...
% 
%     };

AcquisitionCategories = {
    {'T1 3D','anat'},...
    {'T1W 3D','anat'},...
    {'3D T1W','anat'},...
    {'3D T1','anat'},...
    {'s 3D T2','anat'},...
    {'s 3D_FLAIR','anat'},...

    };

SubjectsFolder = dir(RawFolder);
for subj_id=6:length(SubjectsFolder)
    if(strncmp(SubjectsFolder(subj_id).name,'.',1))
        continue
    end
    full_sub_path = fullfile(RawFolder,SubjectsFolder(subj_id).name);
    full_sub_out_path = fullfile(OutputFolder,SubjectsFolder(subj_id).name);
    mkdir(full_sub_out_path);

    SessionsFolder = dir(full_sub_path); % session folder
    for ses_nr=1:length(SessionsFolder)
        if(strncmp(SessionsFolder(ses_nr).name,'.',1))
            continue
        end
        delete(fullfile(TempDirectory,'*'));

        full_sub_ses_path = fullfile(RawFolder,[SubjectsFolder(subj_id).name], [SessionsFolder(ses_nr).name]);
        full_sub_ses_out_path = fullfile(OutputFolder,[SubjectsFolder(subj_id).name], [SessionsFolder(ses_nr).name]);
        mkdir(full_sub_ses_out_path);
        final_prefix = [SubjectsFolder(subj_id).name '_' SessionsFolder(ses_nr).name '_'];

        %         copyfile([full_sub_ses_path '/*'], )
        json_files = dir(fullfile(full_sub_ses_path,'*.json'));

        if(~isempty(json_files))
            for json_id=1:length(json_files)
                if(strncmp(json_files(json_id).name,'.',1))
                    continue
                end
                %                 seq_idx = strfind(AcquisitionTypes,file_content.ProtocolName);
                %                 if(isempty(seq_idx))
                %                     AcquisitionTypes(end+1) = {file_content.ProtocolName};
                %                     seq_idx = length(AcquisitionTypes);
                %                 end
                %                 if iscell(seq_idx); seq_idx = cell2mat(seq_idx); end
                %search for the acquisition categories in the json file
                file_content = spm_jsonread(fullfile(full_sub_ses_path,json_files(json_id).name));
                acq_category = file_content.ProtocolName;

                for cate = 1:length(AcquisitionCategories)
                    tempCat = AcquisitionCategories{cate};
                    tempCatname = tempCat{:,1};
%                     tempCatname = strrep(tempCatname, ' ', '_'); %%%%%%%%%%%%%%%%
                    fprintf('Looking for %s in %s\n', tempCatname, acq_category)
                    disp('')
                    category_exist = strfind(acq_category,tempCatname); %search for acquisition categorie tags in json file

                    %if it finds the categorie, atribute a folder 'anat',
                    %func or dw
                    if ~isempty(category_exist)
                        tempOutFolder = tempCat{:,2};
                        category_out_folder = fullfile(full_sub_ses_out_path, tempOutFolder);
                        mkdir(category_out_folder);

                        % copy nii file to a temp folde
                        search_tag = strrep(acq_category, ' ', '_');
                        nii_file = dir(fullfile(full_sub_ses_path,['*',search_tag,'*', '.nii']));
                        json_file = dir(fullfile(full_sub_ses_path,['*',search_tag,'*', '.json']));
                        if ~isempty(nii_file)
                            for n_nii=1:length(nii_file)
                                disp(fullfile(full_sub_ses_path, nii_file(n_nii).name))
                                copyfile(fullfile(full_sub_ses_path, nii_file(n_nii).name), TempDirectory)
                                movefile(fullfile(TempDirectory, nii_file(n_nii).name),  fullfile(category_out_folder, [final_prefix,nii_file(n_nii).name]))

                                temp_jsn_name = nii_file(n_nii).name; temp_jsn_name=[temp_jsn_name(1:end-4),'.json'];
                                disp(fullfile(full_sub_ses_path, temp_jsn_name))
%                                 copyfile(fullfile(full_sub_ses_path, json_file(njson).name), TempDirectory)
                                temp_exist_jsn=dir(fullfile(full_sub_ses_path, temp_jsn_name));
                                if ~isempty(temp_exist_jsn)
                                    copyfile(fullfile(full_sub_ses_path, temp_jsn_name),  category_out_folder)
                                    movefile(fullfile(category_out_folder, temp_jsn_name),  fullfile(category_out_folder, [final_prefix,temp_jsn_name]))
                                end

                                %Look for bvec and bval names
                                temp_bvec_name = nii_file(n_nii).name; temp_bvec_name=[temp_bvec_name(1:end-4),'.bvec'];
                                temp_exist_bvec=dir(fullfile(full_sub_ses_path, temp_bvec_name));
                                temp_bval_name = nii_file(n_nii).name; temp_bval_name=[temp_bval_name(1:end-4),'.bval'];
                                temp_exist_bval=dir(fullfile(full_sub_ses_path, temp_bval_name));

                                if strcmp(category_out_folder,'dwi')  && ~isempty(temp_exist_bvec) && ~isempty(temp_exist_bval)
%                                     copyfile(fullfile(full_sub_ses_path, temp_bval_name),  category_out_folder)
%                                     movefile(fullfile(category_out_folder, temp_bval_name),  fullfile(category_out_folder, [final_prefix,temp_bval_name]))
%                                     copyfile(fullfile(full_sub_ses_path, temp_bvec_name),  category_out_folder)
%                                     movefile(fullfile(category_out_folder, temp_bvec_name),  fullfile(category_out_folder, [final_prefix,temp_bvec_name]))

                                end
                            
                            end
                        end

                    end
                end
            end
        end
    end
end




