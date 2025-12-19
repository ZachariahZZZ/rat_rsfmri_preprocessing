classdef util
    %UTIL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods(Static)
        function out = find_nii(path)
            names = string({dir(path).name});
            out = arrayfun(@(x) ~isempty(regexp(x,"\.nii$","once")),names);
            out = names(out);
        end
        
        function out = niftiall(path)
            out.info = niftiinfo(path);
            out.data = niftiread(path);
        end
        
        function ax = plot_nii_t(nii_4d,options)
            arguments
                nii_4d 
                options.ax = [];
                options.ti (1,1) double {mustBeNonNan} = 1
                options.c_size (1,1) double {mustBeNonNan} = 5
            end
            for fname = string(fieldnames(options))'
                eval(fname+" = options."+fname+";")
            end
            if isempty(ax)
                ax = axes(figure());
            end
        
            nii_dims = size(nii_4d);
            [px,py,pz] = ndgrid(1:nii_dims(1),1:nii_dims(2),1:nii_dims(3));
        
            pvi = nii_4d(:,:,:,ti);
            pvi(pvi==0) = nan;
            scatter3(ax,px(:),py(:),pz(:),c_size,pvi(:),'filled');
        end
    end
end

