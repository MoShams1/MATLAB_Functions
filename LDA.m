% Mohammad Shams
% 21.June.2021
% m.shamsahmar@gmail.com

function perf = LDA(mat_train,lab_train, mat_test,lab_test)

% build the model
model = fitcdiscr(mat_train,lab_train,'discrimType','diagLinear');

% test the model
lab_pred = predict(model,mat_test);

% calculate the precision of the predictions
cmp = strcmp(lab_test,lab_pred);
perf = sum(cmp)/length(cmp)*100;

end