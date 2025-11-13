%% ----------------------------------------------------
dp_whole = 'C:\Users\lkz5285\Downloads\rat004\';
dp_processed = [dp_whole,'rfmri_processed\'];

%% ----------------------------------------------------
f_names = find_nii(dp_processed);
for fni = 1:length(f_names)
    f_name = f_names(fni);
    f_path = dp_processed+f_name;

    nii_info = niftiinfo(f_path);
    nii_4d = niftiread(f_path);
    nii_dims = nii_info.ImageSize;
    
    c_size = 5;
    [px,py,pz] = ndgrid(1:nii_dims(1),1:nii_dims(2),1:nii_dims(3));
    ti = 1;
    pvi = nii_4d(:,:,:,ti);
    pvi(pvi==0) = nan;
    scatter3(px(:),py(:),pz(:),c_size,pvi(:),'filled');
end







%% functions
function out = find_nii(path)
    names = string({dir(path).name});
    out = arrayfun(@(x) ~isempty(regexp(x,"\.nii$","once")),names);
    out = names(out);
end