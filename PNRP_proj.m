clc
clear all
close all

%% Initializing values
N = 1000;
freq = zeros(1, 2);
freq_open = zeros(1,11);
P_dist = zeros(1,11);
door = zeros(1, N);
p_open_z = zeros(1, 11);

%% generating random distance values
dist = randi([0 10], 1, N);

%% generating probability of door open or close
for k =1:N
    p = rand;
    if p<=dist(k)/10
        door(k)=1;
    end
end

%% counting the number of cases where door open or close
for k =1:N
    if door(k)==1
        freq(2) = freq(2) + 1;
    else 
        freq(1) = freq(1) + 1;
    end
end

P_open = freq(2)/N; % probability that door is open

for k =1:N
    z = dist(k) + 1;
    P_dist(z) = P_dist(z) + 1;
end

P_dist = P_dist/1000; % probability of the distance by which door opens

%% caculating P(Z|open)
for k = 1:N
    if door(k) == 1
        z = dist(k)+1;
        freq_open(z) = freq_open(z)+1;
    end
end

dist = dist/10;

p_z_open = freq_open/sum(freq_open);

% for k = 1:11
%     X = sprintf("P(Z=%f|open) = %f", (k-1)/10, p_z_open(k));
%     disp(X);
% end

%% Applying Bayes Theorem

for k = 1:11
    p_open_z(k) = p_z_open(k)*P_open/P_dist(k);
end

for k = 1:11
    X = sprintf("P(open|Z=%f) = %f", (k-1)/10, p_open_z(k));
    disp(X);
end