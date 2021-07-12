%% Yahtzee - Paul Bandow - 30/06/2021 
% Allows user to play a game of Yahtzee (aka "Kniffel")
% The maximum amount of players is 6
% The rules can be found here: http://www.yahtzee.org.uk/rules.html

clear all
close all

load('Dice.mat');       % loading file for graphical display

num_players=input('Choose number of Players (max. 6).');      % Asking for the number of players
max_rounds=13*num_players;      % Calculating the max number of rounds played

% creating empty scoreboard
scoreboard={'Aces';'Twos';'Threes';'Fours';'Fives';'Sixes';'Three of a Kind';'Four of a Kind';'Full House';'Small Straight';'Large Straight';'Yahtzee';'Chance'};
% Filling scoreboard with appropriate number of columns
for p=1:13
    for q=1:num_players
        scoreboard{p,q+1}=[];
    end
end

% Playing the game for the maximum number of rounds
rounds=0;

while rounds < max_rounds
% Asking who's turn it is to roll the dice    
player=menu('Who`s turn is it?', 'Player 1','Player 2','Player 3','Player 4','Player 5','Player 6')

disp(scoreboard);       % show current scoreboard before every roll

input('Press Enter to roll the dice.');

% Rolling the dice a maximum three times
counter=0;

while counter < 3
    roll_1=randi([1 6],[1 5]);      %Roling 5 dice
    imshow([Dice{roll_1}]);     %displaying the roll graphically
    
    % Asking player what dice to keep
    keep_1=menu('What numbers would you like to keep?','Aces','Twos', 'Threes','Fours','Fives','Sixes','Small Straight','Two Pairs','Full House','Large Straight','Yahtzee','Chance','None');
    
    counter=1;  % counting the first roll
    
    if keep_1 > 8 && keep_1 < 13    % checking if the scoring category involves all five dice
        break
    elseif keep_1 < 7   % keeping only the dice that player picked
        roll_1=roll_1(roll_1==keep_1);
    elseif keep_1 == 8  % asking for the type of pair the player wants to keep
        my_pair_1=input('What is the first number you have twice?');
        my_pair_2=input('What is the second number you have twice?');
        my_pair=[my_pair_1 my_pair_2];
        roll_1=roll_1(ismember(roll_1,my_pair));
    end
    
    % Asking the player how many dice to use in the second roll
    Reroll_1=menu('Roll again?', '1 die', '2 dice','3 dice','4 dice', 'All', 'No, thanks.');
    
    switch Reroll_1
        case 1
            roll_2=randi([1 6]);
            figure (2)
            imshow([Dice{roll_2}]);
            counter=2;
        case 2
            roll_2=randi([1 6],[1 2]);
            figure (2)
            imshow([Dice{roll_2}]);
            counter=2;
        case 3
            roll_2=randi([1 6],[1 3]);
            figure (2)
            imshow([Dice{roll_2}]);
            counter=2;
        case 4
            roll_2=randi([1 6],[1 4]);
            figure (2)
            imshow([Dice{roll_2}]);
            counter=2;
        case 5
            roll_2=randi([1 6],[1 5]);
            figure (2)
            imshow([Dice{roll_2}]);
            counter=2;
            roll_1=0;
        case 6
            roll_2=0;
            roll_3=0;
            break
    end
    
    keep_2=menu('What numbers would you like to keep?','Aces','Twos', 'Threes','Fours','Fives','Sixes','Small Straight','Two Pairs','Full House','Large Straight','Yahtzee','Chance','None','All');
    
    if keep_2 > 8 && keep_2 < 13
        break 
    elseif keep_2 < 7
        roll_2=roll_2(roll_2==keep_2);
    elseif keep_2 == 8
        my_pair_1=input('What is the first number you have twice?');
        my_pair_2=input('What is the second number you have twice?');
        my_pair=[my_pair_1 my_pair_2];
        roll_2=roll_2(ismember(roll_2,my_pair));
    end
    
    Reroll_2=menu('Roll again?', '1 die', '2 dice','3 dice','4 dice', 'All', 'No, thanks.');
    
    switch Reroll_2
        case 1
            roll_3=randi([1 6]);
            figure (3)
            imshow([Dice{roll_3}]);
            counter=3;      % Terminating the while loop 
        case 2
            roll_3=randi([1 6],[1 2]);
            figure (3)
            imshow([Dice{roll_3}]);
            counter=3;
        case 3
            roll_3=randi([1 6],[1 3]);
            figure (3)
            imshow([Dice{roll_3}]);
            counter=3;
        case 4
            roll_3=randi([1 6],[1 4]);
            figure (3)
            imshow([Dice{roll_3}]);
            counter=3;
        case 5
            roll_3=randi([1 6],[1 5]);
            figure (3)
            imshow([Dice{roll_3}]);
            counter=3;
            roll_1=0;
            roll_2=0;
        case 6
            roll_3=0;
            break
    end
   
    keep_3=menu('What numbers would you like to keep?','Aces','Twos', 'Threes','Fours','Fives','Sixes','Small Straight','Chance','Full House','Large Straight','Yahtzee','All');
end

% Picking a result to add to the scoreboard
pick_again=1;
while pick_again==1
    
pick=menu('Please pick the result you want to add to the scoreboard.','Aces','Twos','Threes','Fours','Fives','Sixes','Three of a Kind','Four of a Kind','Full House','Small Straight','Large Straight','Yahtzee','Chance','Cross one off the list');

switch pick
    case 1   %Choosing Aces
        if scoreboard{1,player+1}>=0     % Checking if the category was already scored
            disp('You have already scored in this category. Please pick another.');
        elseif keep_1==1 || keep_2==1 || keep_3==1 || sum([roll_1 roll_2 roll_3]==1)>0      % Checking if player is allowed to score in that category
            result=sum([roll_1 roll_2 roll_3]==1);      % Calculating the score
            scoreboard{1,player+1}=result;      % Adding the score to the scoreboard
            pick_again=0;       % Terminating the while loop
        else
            disp('Your pick does not match what the dice show:');
            disp(roll_1);
            disp(roll_2);
            disp(roll_3);
            disp('Please pick again.');
        end
        
    case 2  %Choosing Twos
        if scoreboard{2,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        elseif keep_1==2 || keep_2==2 || keep_3==2 || sum([roll_1 roll_2 roll_3]==2)>0
            result=(sum([roll_1 roll_2 roll_3]==2))*2;
            scoreboard{2,player+1}=result;
            pick_again=0;
        else
            disp('Your pick does not match what the dice show:');
            disp(roll_1);
            disp(roll_2);
            disp(roll_3);
            disp('Please pick again.');
        end
        
    case 3  %Choosing Threes
        if scoreboard{3,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        elseif keep_1==3 || keep_2==3 || keep_3==3 || sum([roll_1 roll_2 roll_3]==3)>0
            result=(sum([roll_1 roll_2 roll_3]==3))*3;
            scoreboard{3,player+1}=result; 
            pick_again=0;
        else
            disp('Your pick does not match what the dice show:');
            disp(roll_1);
            disp(roll_2);
            disp(roll_3);
            disp('Please pick again.');
        end
        
    case 4  %Choosing Fours
        if scoreboard{4,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        elseif keep_1==4 || keep_2==4 || keep_3==4 || sum([roll_1 roll_2 roll_3]==4)>0
            result=(sum([roll_1 roll_2 roll_3]==4))*4;
            scoreboard{4,player+1}=result; 
            pick_again=0;
        else
            disp('Your pick does not match what the dice show:');
            disp(roll_1);
            disp(roll_2);
            disp(roll_3);
            disp('Please pick again.');
        end
        
    case 5  %Choosing Fives
        if scoreboard{5,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        elseif keep_1==5 || keep_2==5 || keep_3==5 || sum([roll_1 roll_2 roll_3]==5)>0
            result=(sum([roll_1 roll_2 roll_3]==5))*5;
            scoreboard{5,player+1}=result; 
            pick_again=0;
        else
            disp('Your pick does not match what the dice show:');
            disp(roll_1);
            disp(roll_2);
            disp(roll_3);
            disp('Please pick again.');
        end
        
    case 6 %Choosing sixes
        if scoreboard{6,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        elseif keep_1==6 || keep_2==6 || keep_3==6 || sum([roll_1 roll_2 roll_3]==6)>0
            result=(sum([roll_1 roll_2 roll_3]==6))*6;
            scoreboard{6,player+1}=result; 
            pick_again=0;
        else
            disp('Your pick does not match what the dice show:');
            disp(roll_1);
            disp(roll_2);
            disp(roll_3);
            disp('Please pick again.');
        end
        
    case 7  %Choosing three of kind
        if scoreboard{7,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        else
        choose_three=menu('For what number do you have Three of Kind?','Aces','Twos','Threes','Fours','Fives','Sixes');
        switch choose_three
            case 1
                if keep_1==1 || keep_2==1 || keep_3==1 
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==1)>=3
                        result=3+sum(roll_3(roll_3~=1));
                        scoreboard{7,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 2
                if keep_1==2 || keep_2==2 || keep_3==2
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==2)>=3
                        result=6+sum(roll_3(roll_3~=2));
                        scoreboard{7,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 3
                if keep_1==3 || keep_2==3 || keep_3==3
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==3)>=3
                        result=9+sum(roll_3(roll_3~=3));
                        scoreboard{7,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 4
                if keep_1==4 || keep_2==4 || keep_3==4
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==4)>=3
                        result=12+sum(roll_3(roll_3~=4));
                        scoreboard{7,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 5
                if keep_1==5 || keep_2==5 || keep_3==5
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==5)>=3
                        result=15+sum(roll_3(roll_3~=5));
                        scoreboard{7,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 6
                if keep_1==6 || keep_2==6 || keep_3==6
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==6)>=3
                        result=18+sum(roll_3(roll_3~=6));
                        scoreboard{7,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
        end
        end
        
    case 8  %Choosing four of kind
        if scoreboard{8,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        else
        choose_four=menu('For what number do you have Four of Kind?','Aces','Twos','Threes','Fours','Fives','Sixes');
        switch choose_four
            case 1
                if keep_1==1 || keep_2==1 || keep_3==1
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==1)>=4
                        result=4+sum(roll_3(roll_3~=1));
                        scoreboard{8,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 2
                if keep_1==2 || keep_2==2 || keep_3==2
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==2)>=4
                        result=8+sum(roll_3(roll_3~=2));
                        scoreboard{8,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 3
                if keep_1==3 || keep_2==3 || keep_3==3
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==3)>=4
                        result=12+sum(roll_3(roll_3~=3));
                        scoreboard{8,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 4
                if keep_1==4 || keep_2==4 || keep_3==4
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==4)>=4
                        result=16+sum(roll_3(roll_3~=4));
                        scoreboard{8,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 5
                if keep_1==5 || keep_2==5 || keep_3==5
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==5)>=4
                        result=20+sum(roll_3(roll_3~=5));
                        scoreboard{8,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
            case 6
                if keep_1==6 || keep_2==6 || keep_3==6
                    all_rolls=[roll_1 roll_2 roll_3];
                    if sum(all_rolls==6)>=4
                        result=24+sum(roll_3(roll_3~=6));
                        scoreboard{8,player+1}=result;
                        pick_again=0; 
                    else
                        disp('Your pick does not match what the dice show:');
                        disp(roll_1);
                        disp(roll_2);
                        disp(roll_3);
                        disp('Please pick again.');
                    end
                else
                    disp('Your pick does not match what the dice show:');
                    disp(roll_1);
                    disp(roll_2);
                    disp(roll_3);
                    disp('Please pick again.');
                end
        end
        end
        
    case 9 %Choosing Full House
        if scoreboard{9,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        else
            pair=input('What number is the Pair?');
            triplet=input('What number is the Triplet?');
            FH=sort([pair pair triplet triplet triplet]);
            if keep_1==9 && sum(sort(roll_1)==FH)==5
                scoreboard{9,player+1}=25;
                pick_again=0;
            elseif keep_2==9 && sum(ismember([roll_1 roll_2],FH))==5
                scoreboard{9,player+1}=25;
                pick_again=0;
            elseif sum(ismember([roll_1 roll_2 roll_3],FH))==5
                scoreboard{9,player+1}=25;
                pick_again=0;
            else
                disp('Your pick does not match what the dice show:');
                disp(roll_1);
                disp(roll_2);
                disp(roll_3);
                disp('Please pick again.');
            end
        end
        
    case 10 %Choosing Small Straight
        if scoreboard{10,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        else
            smallst=input('Please put in the sequence of your straight in [] and seperate values by commas.');
            if keep_1==7 && sum(ismember(roll_1,smallst))>=4
                scoreboard{10,player+1}=30;
                pick_again=0;
            elseif keep_2==7 && sum(ismember([roll_1 roll_2],smallst))>=4
                scoreboard{10,player+1}=30;
                pick_again=0; 
            elseif keep_3==7 && sum(ismember([roll_1 roll_2 roll_3],smallst))>=4
                scoreboard{10,player+1}=30;
                pick_again=0;
            else
                disp('Your pick does not match what the dice show:');
                disp(roll_1);
                disp(roll_2);
                disp(roll_3);
                disp('Please pick again.');
            end
        end
        
    case 11 %Choosing Large Straight
        if scoreboard{11,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        else
            largest=input('Please put in the sequence of your straight in [] and seperate values by commas');
            if keep_1==10 && sum(ismember(roll_1,largest))>=5
                scoreboard{11,player+1}=40;
                pick_again=0;
            elseif keep_2==10 && sum(ismember([roll_1 roll_2],largest))>=5
                scoreboard{11,player+1}=40;
                pick_again=0; 
            elseif keep_3==10 && sum(ismember([roll_1 roll_2 roll_3],largest))>=5
                scoreboard{11,player+1}=40;
                pick_again=0;
            else
                disp('Your pick does not match what the dice show:');
                disp(roll_1);
                disp(roll_2);
                disp(roll_3);
                disp('Please pick again.');
            end
        end
        
    case 12 %Choosing Yahtzee
        if scoreboard{12,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        else
            yat=input('What is the value of your Yahtzee?');
            yahtze=[yat yat yat yat yat];
            if keep_1==11 && sum(ismember(roll_1,yahtze))==5
                scoreboard{12,player+1}=50;
                pick_again=0;
            elseif keep_2==11 && sum(ismember([roll_1 roll_2],yahtze))>=5
                scoreboard{12,player+1}=50;
                pick_again=0;
            elseif sum(ismember([roll_1 roll_2 roll_3],yahtze))>=5
                scoreboard{12,player+1}=50;
                pick_again=0;
            else
                disp('Your pick does not match what the dice show:');
                disp(roll_1);
                disp(roll_2);
                disp(roll_3);
                disp('Please pick again.');
            end
        end
        
    case 13 %Choosing Chance
        if scoreboard{13,player+1}>=0
            disp('You have already scored in this category. Please pick another.');
        else
            scoreboard{13,player+1}=sum([roll_1 roll_2 roll_3]);
            pick_again=0;
        end
        
    case 14 %Crossing one category off the list
        cross_again=1;
        
        while cross_again==1
            cross=menu('What category do you want to cross off?','Aces','Twos','Threes','Fours','Fives','Sixes','Three of a Kind','Four of a Kind','Full House','Small Straight','Large Straight','Yahtzee','Chance');

            switch cross
                case 1
                    if scoreboard{1,player+1}>=0        % Checking if the category was already filled
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{1,player+1}=0;   % Setting the score to zero
                        pick_again=0;
                        cross_again=0;      % Terminating the while loops
                    end
                    
                case 2
                    if scoreboard{2,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{2,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 3
                    if scoreboard{3,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{3,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 4
                    if scoreboard{4,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{4,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 5
                    if scoreboard{5,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{5,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                
                case 6
                    if scoreboard{6,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{6,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 7
                    if scoreboard{7,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{7,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 8
                    if scoreboard{8,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{8,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 9 
                    if scoreboard{9,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{9,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 10
                    if scoreboard{10,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{10,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 11
                    if scoreboard{11,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{11,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 12
                    if scoreboard{12,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{12,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
                    
                case 13
                    if scoreboard{13,player+1}>=0
                        disp('You have already scored in this category. Please pick another.');
                    else
                        scoreboard{13,player+1}=0;
                        pick_again=0;
                        cross_again=0;
                    end
            end
        end
              
end

end
rounds=rounds+1;    %Counting the rounds that were played
close all           %Closing all windows before the next round
clear roll_1 roll_2 roll_3
clear keep_1 keep_2 keep_3
end

%calculating the final score for each player
scores_arr=[scoreboard{1:13,2:num_players+1}];
scores_tab=reshape(scores_arr,[length(scores_arr)/num_players,num_players]);
tot_scores=sum(scores_tab)

%Adding another row with the the total scor for each player
scoreboard{14,1}='Total';

for k=1:num_players
    scoreboard{14,1+k}=tot_scores(k);
end

disp('Game Over. Final Score:');
disp(scoreboard);
