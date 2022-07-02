% plotAll(A)
% 03/01/2019
% Mohammad Shams (m.shamsahmar@gmail.com)
% A: input matrix (trial x time)
function plotAll(x,A,c)
for i = 1:size(A,1)
    plot(x,A(i,:),'color',c)
    hold on
end