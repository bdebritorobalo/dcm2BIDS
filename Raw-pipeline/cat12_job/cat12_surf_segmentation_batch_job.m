%-----------------------------------------------------------------------
% Job saved on 08-Jun-2022 16:46:06 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.tools.cat.long.datalong.subjects = {
                                                       {
                                                       '/Users/brunorobalo/Desktop/DTI_PIEN/sub-0001/sub-0001_ses-mri001_s_T1_3D_TFE_20200910114848_rescale_1x1x1.nii,1'
                                                       '/Users/brunorobalo/Desktop/DTI_PIEN/sub-0001/sub-0001_ses-mri002_s_T1_3D_TFE_20200914083648_rescale_1x1x1.nii,1'
                                                       '/Users/brunorobalo/Desktop/DTI_PIEN/sub-0001/sub-0001_ses-mri003_s_3D_T1W_cs_20201210125718_rescale_1x1x1.nii,1'
                                                       '/Users/brunorobalo/Desktop/DTI_PIEN/sub-0001/sub-0001_ses-mri004_s_T1_3D_TFE_20210108101445_rescale_1x1x1.nii,1'
                                                       '/Users/brunorobalo/Desktop/DTI_PIEN/sub-0001/sub-0001_ses-mri005_s_3D_T1W_cs_20210414160319_rescale_1x1x1.nii,1'
                                                       '/Users/brunorobalo/Desktop/DTI_PIEN/sub-0001/sub-0001_ses-mri006_s_T1_3D_TFE_20210728153950_rescale_1x1x1.nii,1'
                                                       }
                                                       }';
matlabbatch{1}.spm.tools.cat.long.longmodel = 1;
matlabbatch{1}.spm.tools.cat.long.enablepriors = 1;
matlabbatch{1}.spm.tools.cat.long.bstr = 0;
matlabbatch{1}.spm.tools.cat.long.nproc = 8;
matlabbatch{1}.spm.tools.cat.long.opts.tpm = {'/Volumes/pmc_mpartanen/MRIdata/Code/spm12/tpm/TPM.nii'};
matlabbatch{1}.spm.tools.cat.long.opts.affreg = 'mni';
matlabbatch{1}.spm.tools.cat.long.opts.ngaus = [1 1 2 3 4 2];
matlabbatch{1}.spm.tools.cat.long.opts.warpreg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.tools.cat.long.opts.bias.biasstr = 0.5;
matlabbatch{1}.spm.tools.cat.long.opts.acc.accstr = 0.5;
matlabbatch{1}.spm.tools.cat.long.opts.redspmres = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.restypes.optimal = [1 0.3];
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.setCOM = 1;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.APP = 1070;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.affmod = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.NCstr = -Inf;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.spm_kamap = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.LASstr = 0.5;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.LASmyostr = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.gcutstr = 2;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.cleanupstr = 0.5;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.BVCstr = 0.5;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.WMHC = 2;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.SLC = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.segmentation.mrf = 1;
matlabbatch{1}.spm.tools.cat.long.extopts.registration.T1 = {'/Volumes/pmc_mpartanen/MRIdata/Code/spm12/toolbox/cat12/templates_MNI152NLin2009cAsym/T1.nii'};
matlabbatch{1}.spm.tools.cat.long.extopts.registration.brainmask = {'/Volumes/pmc_mpartanen/MRIdata/Code/spm12/toolbox/cat12/templates_MNI152NLin2009cAsym/brainmask.nii'};
matlabbatch{1}.spm.tools.cat.long.extopts.registration.cat12atlas = {'/Volumes/pmc_mpartanen/MRIdata/Code/spm12/toolbox/cat12/templates_MNI152NLin2009cAsym/cat.nii'};
matlabbatch{1}.spm.tools.cat.long.extopts.registration.darteltpm = {'/Volumes/pmc_mpartanen/MRIdata/Code/spm12/toolbox/cat12/templates_MNI152NLin2009cAsym/Template_1_Dartel.nii'};
matlabbatch{1}.spm.tools.cat.long.extopts.registration.shootingtpm = {'/Volumes/pmc_mpartanen/MRIdata/Code/spm12/toolbox/cat12/templates_MNI152NLin2009cAsym/Template_0_GS.nii'};
matlabbatch{1}.spm.tools.cat.long.extopts.registration.regstr = 0.5;
matlabbatch{1}.spm.tools.cat.long.extopts.registration.bb = 12;
matlabbatch{1}.spm.tools.cat.long.extopts.registration.vox = 1.5;
matlabbatch{1}.spm.tools.cat.long.extopts.surface.pbtres = 0.5;
matlabbatch{1}.spm.tools.cat.long.extopts.surface.pbtmethod = 'pbt2x';
matlabbatch{1}.spm.tools.cat.long.extopts.surface.SRP = 22;
matlabbatch{1}.spm.tools.cat.long.extopts.surface.reduce_mesh = 1;
matlabbatch{1}.spm.tools.cat.long.extopts.surface.vdist = 2;
matlabbatch{1}.spm.tools.cat.long.extopts.surface.scale_cortex = 0.7;
matlabbatch{1}.spm.tools.cat.long.extopts.surface.add_parahipp = 0.1;
matlabbatch{1}.spm.tools.cat.long.extopts.surface.close_parahipp = 1;
matlabbatch{1}.spm.tools.cat.long.extopts.admin.experimental = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.admin.new_release = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.admin.lazy = 0;
matlabbatch{1}.spm.tools.cat.long.extopts.admin.ignoreErrors = 1;
matlabbatch{1}.spm.tools.cat.long.extopts.admin.verb = 2;
matlabbatch{1}.spm.tools.cat.long.extopts.admin.print = 2;
matlabbatch{1}.spm.tools.cat.long.output.BIDS.BIDSno = 1;
matlabbatch{1}.spm.tools.cat.long.output.surface = 1;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.neuromorphometrics = 1;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.lpba40 = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.cobra = 1;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.hammers = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.thalamus = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.ibsr = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.aal3 = 1;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.mori = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.anatomy3 = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.julichbrain = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.Schaefer2018_100Parcels_17Networks_order = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.Schaefer2018_200Parcels_17Networks_order = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.Schaefer2018_400Parcels_17Networks_order = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.Schaefer2018_600Parcels_17Networks_order = 0;
matlabbatch{1}.spm.tools.cat.long.ROImenu.atlases.ownatlas = {''};
matlabbatch{1}.spm.tools.cat.long.longTPM = 1;
matlabbatch{1}.spm.tools.cat.long.modulate = 1;
matlabbatch{1}.spm.tools.cat.long.dartel = 0;
matlabbatch{1}.spm.tools.cat.long.delete_temp = 1;
