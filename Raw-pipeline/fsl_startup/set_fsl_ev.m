setenv('PATH', [getenv('PATH') ':/usr/local/fsl/bin']);
[status, res] = system('flirt');

% FSL Setup
setenv( 'FSLDIR', '/usr/local/fsl' );
fsldir = getenv('FSLDIR');
fsldirmpath = sprintf('%s/etc/matlab',fsldir);
path(path, fsldirmpath);
clear fsldir fsldirmpath;

fsldir = '/usr/local/fsl'; 
fsldirmpath = sprintf('%s/etc/matlab',fsldir);
setenv('FSLDIR', fsldir);
setenv('FSLOUTPUTTYPE', 'NIFTI_GZ');
path(path, fsldirmpath);
% clear fsldir fsldirmpath;