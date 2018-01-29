function [train_SL,test_SL,test_number]= GenerateSample(labels,train_number,no_classes)

%description:generate training sampels and test samples roundly;
%input:
%      labels:ground truth 
%      train_number:training samples per class
%      no_classes:number of class
%output:
%      train_SL:the index and label of selected training samples
%      test_SL:the index and label of selected test samples


Train_Label = [];
Train_index = [];
count=[];
for ii = 1: no_classes
   index_ii =  find(labels == ii);
   count =[count,length(index_ii)];
   class_ii = ones(length(index_ii),1)* ii;
   Train_Label = [Train_Label class_ii'];
   Train_index = [Train_index index_ii'];   
end
trainall = zeros(2,length(Train_index));
trainall(1,:) = Train_index;
trainall(2,:) = Train_Label;

indexes =[];

all_sample = [];
for i = 1: no_classes
  W_Class_Index = find(Train_Label == i);
  all_sample = [all_sample,length(W_Class_Index)];
  Random_num = randperm(length(W_Class_Index));
  Random_Index = W_Class_Index(Random_num);
  Tr_Index = Random_Index(1:train_number(i));
  indexes = [indexes Tr_Index];
end   
test_number = all_sample -  train_number;
indexes = indexes';
train_SL = trainall(:,indexes);
test_SL = trainall;
test_SL(:,indexes) = [];
end