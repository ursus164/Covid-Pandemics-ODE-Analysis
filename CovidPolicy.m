clear all; close all;

% Uzupełnienie modelu SEIRD o politykę epidemiologiczną wprowadzającą
% środki prewencyjne w trakcie pandemii.

%% Parametry początkowe (przybliżone dane z internetu)
duration = 7;           % ilość dni jakie spędza osoba w grupie I

R0 = 5.2;               % Liczba osób z grupy S (Susceptible) jakie początkowo zaraża pojedyncza zakażona osoba 

N = 37.75e6;            % Populacja polski
beta = R0/(N*duration)  % współczynnik kontaktu z innymi osobami

tspan1 = 0:1:120;       % Bez polityki epidemiologicznej
tspan2 = 121:1:365;     % Po wdrożeniu polityki epidemiologicznej np dystans społeczny itd...

%% Rozwiązanie równań ODE

y0 = [N-6,0,6,0,0];
[t,y] = ode45(@(t,y) odefunc(t,y,beta), tspan1, y0)

y2 = [y(end,1),y(end,2),y(end,3),y(end,4),y(end,5)];            % przyjęcie stanu populacji z końca pierwszego okresu jako początek dla drugiego
[t,y2] = ode45(@(t,y) odefunc(t,y,beta/4), tspan2, y2);         % redukcja beta symuluje wprowadzenie środków prewencyjnych       

y_combined = [y;y2];   % połączenie symulacji z obu faz tzn przed wprowadzeniem polityki i po.  

%% Plot
figure;
subplot(2,1,2)
plot(0:1:365, y_combined,'LineWidth',1.5,'MarkerSize',18);
legend('Podatni na zakażenie','Zainfekowani, ale bezobjawowi i niezaraźliwi','Zakażeni i zaraźliwi','Wyzdrowiali lub odporni','Zmarli','Location','Best')
xlabel('Days after March 7,2020');
ylabel('Population');
title('Predicated Spread of COVID-19 in Poland');
grid on;
grid minor;
set(gca,'FontSize',15);

%% Symulacja MonteCarlo przebiegu pandemii dla losowych parametrów

num_simulations = 100; % Liczba symulacji Monte Carlo
results = zeros(num_simulations, length(tspan1) + length(tspan2), 5); % Macierz do przechowywania wyników

for i = 1:num_simulations
    % Generowanie losowych parametrów
    [beta, death_rate] = generateRandomParameters();
    
    % Symulacja przed wprowadzeniem polityki
    y0 = [N-6,0,6,0,0];             % wektor początkowy

    [t1, y1] = ode45(@(t,y) odefunc(t,y,beta), tspan1, y0);
    
    % Symulacja po wprowadzeniu polityki
    y2 = [y1(end,1),y1(end,2),y1(end,3),y1(end,4),y1(end,5)];
    [t2, y2] = ode45(@(t,y) odefunc(t,y,beta/4), tspan2, y2);
    
    % Połączenie wyników z obu faz
    y_combined = [y1; y2];
    
    % Zapis wyników do macierzy
    results(i, :, :) = y_combined;
end

% Wyświetlenie wyników (średnia i odchylenie standardowe)
mean_results = mean(results, 1);
std_dev_results = std(results, 1);

% Wykresy dla średnich wyników
subplot(2,1,1); % Drugi wykres na dole
plot(0:1:365, squeeze(mean_results(:, :, 1)), 'b', 'LineWidth', 1.5);
hold on;
plot(0:1:365, squeeze(mean_results(:, :, 2)), 'g', 'LineWidth', 1.5);
plot(0:1:365, squeeze(mean_results(:, :, 3)), 'r', 'LineWidth', 1.5);
plot(0:1:365, squeeze(mean_results(:, :, 4)), 'c', 'LineWidth', 1.5);
plot(0:1:365, squeeze(mean_results(:, :, 5)), 'm', 'LineWidth', 1.5);

xlabel('Days after March 7, 2020');
ylabel('Average Population');
legend('Podatni na zakażenie','Zainfekowani, ale bezobjawowi i niezaraźliwi','Zakażeni i zaraźliwi','Wyzdrowiali lub odporni','Zmarli','Location','Best')
title('Average Predicted Spread of COVID-19 in Poland (Monte Carlo)');
grid on;
grid minor;
set(gca,'FontSize',15);
