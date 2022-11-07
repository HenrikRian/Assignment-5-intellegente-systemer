%% Start
clear;close all;clc;    
tic                     

%% Select Name String
Name  = 'Henrik Rian';

%% Parameters                    
popSize = 500;                                 % Population Size
Chromo  = length(Name);                         % Chromosome Size
mutRate = 0.01;                                  % Mutation Rate
crossover = 1;                                  % Uniform crossover
NoGen = 1000;                                   % Number of generations


count = 1;                                                                        
best    = Inf;                                
MaxVal  = max(double(Name));                  
ideal   = double(Name);                       

selection = 1;                                  % 1: 50% Selection

crossover = 1;                                 
plotting = 1;                                  
%% Initialize Population
Pop = round(rand(popSize,Chromo)*(MaxVal-1)+1); 

initF = min(sum(abs(bsxfun(@minus,Pop,ideal)),2));   

for Gen = 1:NoGen % Number of generations                                 
    %% Fitness function
    
    
    F = sum(abs(bsxfun(@minus,Pop,ideal)),2);       
    
    [current,currentChromo] = min(F);  
    
    % Stores New Best Values and Prints New Best Scores
    if current < best
        best = current;                     
        bestChromo = Pop(currentChromo,:);  
    
     %Plotting
        if plotting == 1
        B(count) = best;                   
        G(count) = Gen;                    
        count = count + 1;                  
        end
      
        
        fprintf('Gen: %d  |  Fitness: %d  |  ',Gen, best);  
        disp(char(bestChromo));                             
    elseif best == 0
        break                                               
    end

    %% Selection 
    % 50% Selection
    if selection == 1
    [~,V] = sort(F,'descend');                                      
    V = V(popSize/2+1:end);                                         
    W = V(round(rand(2*popSize,1)*(popSize/2-1)+1))';                  
    end
    
    %% Crossover
    
    % UNIFORM CROSSOVER
    if crossover == 1
    idx = logical(round(rand(size(Pop))));                          
    Pop2 = Pop(W(1:2:end),:);                                       
    P2A = Pop(W(2:2:end),:);                                        
    Pop2(idx) = P2A(idx);
    end
    
  
    %% Mutation 
    idx = rand(size(Pop2))<mutRate;                                 
    Pop2(idx) = round(rand([1,sum(sum(idx))])*(MaxVal-1)+1);        
    
    %% Reset Poplulations
    Pop = Pop2;                                                   
   
end

toc 


if plotting == 1
% Plot Best Values/Gen
figure(1)
plot(G(:),B(:), '-r')
axis([0 Gen 0 initF])
title('Fitness Over Time');
xlabel('Fitness');
ylabel('Generation');                  
end


