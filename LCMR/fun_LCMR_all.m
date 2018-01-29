function [all_samples] =  fun_LCMR_all(RD_hsi,wnd_sz,K)



tol = 1e-3;
sz = size(RD_hsi);
scale = floor(wnd_sz/2);
d = sz(3);
RD_Ex = padarray(RD_hsi,[scale scale],'symmetric'  );
id = ceil(wnd_sz*wnd_sz/2);

all_samples = zeros(d, d,sz(1)*sz(2));  

 for j = 1:sz(1)*sz(2)
           [X,Y] = ind2sub([sz(1),sz(2)],j);
           X_new = X+scale;
           Y_new = Y+scale;         
           X_range = [X_new-scale : X_new+scale];
           Y_range = [Y_new-scale : Y_new+scale];
           tt_RD_temp = RD_Ex(X_range,Y_range,:); 
           [r,l,h]=size(tt_RD_temp);
          tt_RD_DAT = reshape(tt_RD_temp,[r*l,h])';
           norm_tmp = sqrt(sum(tt_RD_DAT.^2));
           norm_blocks_2d = tt_RD_DAT./repmat(norm_tmp,h,1);
           center_pixel = norm_blocks_2d(:,id);
           cor = center_pixel'*norm_blocks_2d;
           [val,sort_id] = sort(cor,'descend');
           sli_id = sort_id(1:K);
            tmp_mat = tt_RD_DAT(:,sli_id);
            tmp_mat = scale_func(tmp_mat);
            mean_mat = mean(tmp_mat,2);
            centered_mat = tmp_mat-repmat(mean_mat,1,size(tmp_mat,2));
            tmp = centered_mat*centered_mat'/((size(tmp_mat,2))-1);
            all_samples(:,:,j) = logm(tmp+tol*eye(size(tmp,1))*(trace(tmp))); 
 end


end
