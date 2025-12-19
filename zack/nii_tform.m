import util.*


%%
data = niftiall("C:\Users\lkz5285\Downloads\rsfMRI_test\rat004\rfmri_intermediate\01_despiked.nii.gz");
nii = data.data;
nii = flip(nii,2);
niftiwrite(nii,"C:\Users\lkz5285\Downloads\rsfMRI_test\rat004\rfmri_intermediate\01_despiked_flipped.nii",data.info)

%%
data = niftiall("C:\Users\lkz5285\Downloads\rsfMRI_test\rat004\rfmri_intermediate\01_despiked.nii.gz");
nii = data.data;

tmp = nii;
tmp(tmp<100) = nan;
ax1 = plot_nii_t(tmp,ti=1);
xlabel(ax1,"x");ylabel(ax1,"y");zlabel(ax1,"z");

tmp = flip(tmp,2);
ax2 = plot_nii_t(tmp,ti=1);
xlabel(ax2,"x");ylabel(ax2,"y");zlabel(ax2,"z");