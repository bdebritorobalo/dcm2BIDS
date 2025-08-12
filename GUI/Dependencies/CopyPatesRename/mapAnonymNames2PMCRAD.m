%%  Map folder name RADs to PMC IDS
copy_folder = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/download'; 
paste_folder = '/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/BRAIN_ONLY';
koppel = readtable('/Volumes/pmc_mpartanen/MRIdata/PMCLAB2019.084/Koppellijst_excel.xlsx');
koppel.Var1 = num2cell(koppel.Var1);
% Read all anonymous folders 
Anonym = dir(fullfile(copy_folder, 'Anonymous*')); %read all folders that start with Anonymous
part2Anonym_names = {Anonym.name}'; %names only


Anonym = dir(fullfile(copy_folder, 'Anonymous*')); %read all folders that start with Anonymous
Anonym_names = {Anonym.name}'; %names only



for i=30:34      %:length(Anonym_names)
    RADs = dir(fullfile(copy_folder, Anonym_names{i}, '*PMCRA*')); %read all PMCRAD in each anonymous folder
    disp(Anonym_names{i})
    cd(fullfile(copy_folder, Anonym_names{i}))

%     find PMC RADS that are not HERSENEN
    RADfolders=dir(pwd);
    RADfolders = RADfolders(endsWith({RADfolders.name}, 'HERSENEN'));

    %find RADID within then long folder name and map to a PMCID
    tmp_name = RADfolders(1).name;
    k = strfind(tmp_name,'-');
    RAD1_name = tmp_name(k+1:k+11);

    %look for this RAD ID in the excel file, var 3 is RADID 
    k2 = find(contains(koppel.Var3, RAD1_name));

    if k2
        pmcid=koppel.Var2{k2};
        koppel.Var1(k2)= Anonym_names(i);
    else
        error('RAD ID does not exist in koppelijst')
    end

    %Create the PMCID folder and copy all the PMC RADs and rename them
%     Create PMCID first
    mkdir(fullfile(paste_folder, pmcid))
    pmcid_paste_folder = fullfile(paste_folder, pmcid);

    %now copy each PMCRAD and change their names    
    for j=1:length({RADfolders.name})
        tmp_name = RADfolders(j).name;
        k = strfind(tmp_name,'-');
        RAD1_name = tmp_name(k+1:k+11);

        copy_rad_folder = fullfile(copy_folder, Anonym_names{i}, RADfolders(j).name); 
        paste_rad_folder = fullfile(pmcid_paste_folder, RAD1_name); mkdir(paste_rad_folder);
        

        xcmd = ['cp -r ' copy_rad_folder ' ' paste_rad_folder];
        [status,result] = system(xcmd); %copy with Linux cp, matlab is too slow. 

    end
end

