%% Craps - Paul Bandow - 29/06/2021 
% Allows user to play a game of Craps
% Rules:
%     Craps is a dice game played with 2 dice.
%     The player begins by making first roll:
%        a) If the roll is a 7 or 11 -> Player wins
%        b) If the roll is a 2, 3, or 12 -> Player loses
%     Otherwise the player continues rolling:
%        a) If after the first roll, the player rolls a 7 -> Player loses
%        b) If the player rolls the same total as the first roll -> Player wins
%     Player continues rolling until the first roll is repeated or a 7 is rolled.
%     Player can start game with any amount of money, and can bet any amount (<= total) for each game, until out of money. No negative bets. Have the pay off 1 to 1 on the bets. 

clear all
close all

disp('Let´s roll some dice!');
money=input ('How much money do you have to play? ');       % Asking for the amount of money the user has to play

answer=1;       % Defining a variable to start the while loop

load('Dice.mat');           % Loading file for image display of dice 

while money>0 && answer==1
    fprintf('You currently have %0.2f dollars.\n',money);
    bet=input('How much would you like to bet? ');      % Asking to user to put a bet
    
    % Checking if user has enough money left for the bet
    if bet > money
        bet=input('You don´t have enough money left. Please place a new bet. ');
    end
    
    % Rolling two dice
    dice1=randi(6);
    dice2=randi(6);
    dicesum=dice1+dice2;
    
    imshow([Dice{[dice1 dice2]}]);      % Displaying dice roll
    
    % Checking if the user wins or loses on the first roll
    if dicesum==7 || dicesum==11
        money=money+bet;        %Calculating win
        fprintf('You win! The dice show: %i and %i.\n',dice1,dice2);
        answer=menu('Would you like to play again?', 'Yes', 'No');      % If answer is Yes while loop will start from the top
    elseif dicesum==2 || dicesum==3 || dicesum==12
        money=money-bet;
        fprintf('You lose! The dice show: %i and %i.\n',dice1,dice2);
        answer=menu('Would you like to play again?', 'Yes', 'No');
    else
        fprintf('The dice show: %i and %i.\n',dice1,dice2);
        input('Press Enter to roll again.');
        
        close all       %Closing display of the first roll
        
        % Going into second roll
        new_dicesum=0;
        
        % Loop will continue as long as user doesn't win or lose
        while new_dicesum ~= 7 || new_dicesum ~= dicesum
            
            % Rolling dice again
            dice3=randi(6);
            dice4=randi(6);
            new_dicesum=dice3+dice4;
            imshow([Dice{[dice3 dice4]}]);

                if new_dicesum == 7
                    money=money-bet;
                    fprintf('You lose! The dice show: %i and %i.\n',dice3,dice4);
                    answer=menu('Would you like to play again?', 'Yes', 'No');
                    break;
                elseif new_dicesum == dicesum
                    money=money+bet;
                    fprintf('You win! The dice show: %i and %i.\n',dice3,dice4);
                    answer=menu('Would you like to play again?', 'Yes', 'No');
                    break;
                else
                    fprintf('The dice show: %i and %i.\n',dice3,dice4);
                    input('Press Enter to roll again.');
                    close all
                end
        end  
    end
    close all
end

% Ending the game
if answer == 2
    fprintf('Thank you for playing. You now have %0.2f dollars.\n',money);
elseif answer==1 && money<=0    
    disp('Sorry, you lost all your money!');
end