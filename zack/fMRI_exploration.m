import util.*

%% -------------------- fc plot --------------------------------
for fc_plot_toggle = []
tmp = niftiread("C:\Users\lkz5285\Documents\GitHub\rat_rsfmri_preprocessing\fc_analysis\group_FC_tval_180ROI.nii");
ax =axes();
imagesc(ax,tmp);
axis(ax,"equal");
colormap(ax,"turbo");
ax.Colormap = [ax.Colormap(10:end,:);0,0,0];
end


%% --------------------- ICA plot ------------------------------
for ICA_plot_toggle = []
tmp = niftiall("C:\Users\lkz5285\Documents\GitHub\rat_rsfmri_preprocessing\fc_analysis\group_ICA_28.nii");
plot_nii_t(tmp.data,ti=28);
end


%% ---------------------------------------------------
tmp = niftiall('C:\Users\lkz5285\Documents\GitHub\rat_rsfmri_preprocessing\fc_analysis\Swanson_180ROI_64x64x20.nii');
plot_nii_t(abs(tmp.data));

%% ----------------------------------------------------
close all;clear;clc;
dp_whole = 'C:\Users\lkz5285\Downloads\rat004\';
dp_processed = [dp_whole,'rfmri_processed\'];


%% ----------------------------------------------------
roi180 = niftiall('C:\Users\lkz5285\Documents\GitHub\rat_rsfmri_preprocessing\fc_analysis\Swanson_180ROI_64x64x20.nii');
f_names = find_nii(dp_processed);
for fni = 1:length(f_names)
    f_name = f_names(fni);
    f_path = dp_processed+f_name;

    nii_info = niftiinfo(f_path);
    nii_4d = niftiread(f_path);
    nii_dims = nii_info.ImageSize;
    
    plot_nii_t(nii_4d);
end


%%
msk = repmat(roi180.data==19,[1,1,1,size(nii_4d,4)]);
tmp = nii_4d(msk);
tmp1 = nii_4d .* msk;
tmp2 = tmp1(:);
unique(sum(tmp2,'all')-sum(tmp,'all'))



%% functions
% function out = find_nii(path)
%     names = string({dir(path).name});
%     out = arrayfun(@(x) ~isempty(regexp(x,"\.nii$","once")),names);
%     out = names(out);
% end
% 
% function out = niftiall(path)
%     out.info = niftiinfo(path);
%     out.data = niftiread(path);
% end
% 
% function ax = plot_nii_t(nii_4d,options)
%     arguments
%         nii_4d 
%         options.ax = [];
%         options.ti (1,1) double {mustBeNonNan} = 1
%         options.c_size (1,1) double {mustBeNonNan} = 5
%     end
%     for fname = string(fieldnames(options))'
%         eval(fname+" = options."+fname+";")
%     end
%     if isempty(ax)
%         ax = axes(figure());
%     end
% 
%     nii_dims = size(nii_4d);
%     [px,py,pz] = ndgrid(1:nii_dims(1),1:nii_dims(2),1:nii_dims(3));
% 
%     pvi = nii_4d(:,:,:,ti);
%     pvi(pvi==0) = nan;
%     scatter3(ax,px(:),py(:),pz(:),c_size,pvi(:),'filled');
% end