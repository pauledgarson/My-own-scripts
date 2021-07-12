%% DiceSeven - Paul Bandow - 18/06/2021 
% Allows user to play a dice of over/under or equal seven
% Rules:
% 1. The game is played with two dice
% 2. The player bets whether he/she will roll Under 7, Over 7, or Exactly 7
% 3. The player specifies how much money he/she is betting on the roll
% 4. The player rolls the dice
% 5. If the player bets incorrectly, he/she loses the amount of money in the bet
% 6. If the player bets correctly, the payoff is 1:1 for Under 7 and for Over 7 (that is, if the bet was $1 then the player wins $1) and is 4:1 for Exactly 7 (that is, if the bet was $1 then the player wins $4 for betting on and successfully rolling a 7).
% Input: Total amount of money, the user has at the beginning
%        Amount of money the user wants to bet at each round
%        Menu Statement to choose bet (over,under or equal 7)

% display of dice images added 29/06/2021

load('Dice.mat');       %loading file for image display

disp('Let´s roll some dice!');

money=input ('How much money do you have to play? ');       % Asking player for the total amount of money to play the game 

% Looping through, while the player still has money and wants to play again
answer=1;

while money>0 && answer==1
    fprintf('You currently have %0.2f dollars.\n',money);       
    guess=menu('What is your bet?', 'Under 7', 'Over 7', 'Exactly 7');      % Asking the player for his bet
    bet=input('How much would you like to bet? ');          % Asking the play for the amount of money he wants to bet on the roll
    
    % Checking if the player has enough money left for his bet
    if bet > money
        bet=input('You don´t have enough money left. Please place a new bet. ');
    end
    
    % Rolling two dice
    dice1=randi(6);
    dice2=randi(6);
    dicesum=dice1+dice2;
    
    imshow([Dice{[dice1 dice2]}]);      %displaying the roll as image
    
    % Checking if the roll is over/under or equal 7
    if dicesum == 7
        result=3;
    elseif dicesum > 7
        result=2;
    elseif dicesum < 7
        result=1;
    end
    
    % Checking if the player was correct
    if result == guess
        money=money+bet;        %calculating pay out for right bet
        fprintf('You won! The dice show: %i and %i.\n',dice1,dice2);  
    elseif result==guess && dicesum==7
        money=money+bet*4       %calculating pay out for right bet
        fprintf('You won! The dice show: %i and %i.\n',dice1,dice2);
    else
        money=money-bet;        %calculating loss for wrong bet
        fprintf('You lost! The dice show: %i and %i.\n',dice1,dice2);
    end
    
    % Asking player for another round
    answer=menu('Would you like to play again?', 'Yes', 'No');
    
    close all
end

%ending the game
if answer == 2
    fprintf('Thank you for playing. You now have %0.2f dollars.\n',money);
elseif answer==1 && money<=0    
    disp('Sorry, you lost all your money!');
end

