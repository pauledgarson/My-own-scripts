 
load('Dice.mat');
roll= randi([1 6],[1 5]);
imshow([Dice{roll}]);

fprintf('%i ',roll)