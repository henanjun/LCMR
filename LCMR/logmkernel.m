function kernel_matrix = logmkernel(data1,data2)
  X1 = reshape(data1, size(data1, 1) * size(data1, 2), size(data1, 3))';
  X2 = reshape(data2, size(data2, 1) * size(data2, 2), size(data2, 3))';
   kernel_matrix =   X1*X2';
end