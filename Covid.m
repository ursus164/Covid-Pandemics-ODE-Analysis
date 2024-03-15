% Modelowanie pandemii COVID modelem SEIRD

% S (Susceptible) - Podatni: Osoby, które mogą zachorować po kontakcie z zakażonym.
% E (Exposed) - Narażeni: Osoby, które zostały zarażone, ale jeszcze nie wykazują objawów i nie zarażają innych. To jest główna różnica między modelem SEIRD a SIR – uwzględnienie okresu inkubacji.
% I (Infected) - Zakażeni: Osoby, które są zakażone i zaraźliwe. Mogą one przekazać chorobę innym osobom z grupy S.
% R (Recovered) - Wyzdrowiali: Osoby, które wyzdrowiały po zakażeniu i są teraz odporne lub przynajmniej tymczasowo nie są w stanie ponownie zachorować.
% D (Deceased) - Zmarli: Osoby, które zmarły z powodu choroby.

clear all; close all;
%% Parametry początkowe (przybliżone dane z internetu)
pre_infec = 5.2;        % ilość dni w jakiej osoba przechodzi z grupy E (narażeni) do grupy I (zainfekowani)
f = 1/pre_infec;        % szybkość przejścia

duration = 7;           % ilość dni jakie spędza osoba w grupie I
r = 1/duration;         % szybkość wyzdrowienia / śmierci

R0 = 3.2;               % Liczba osób z grupy S (Susceptible) jakie początkowo zaraża pojedyncza zakażona osoba  

N = 37.75e6;            % Populacja polski
beta = R0/(N*duration);  % współczynnik kontaktu z innymi osobami (zarażenia)

%% Rozwiązanie równań ODE
predictTime = 0:1:365;          % obserwacja co będzie się działo w przyszłym roku
y0 = [N-6,0,6,0,0];               % macierz z osobami z grup: S, E, I, R ,D na dzien 7.03.2020 -> początek pandemii

[t,y] = ode45(@(t,y) odefunc(t,y,beta), predictTime, y0);

%% Plot SEIRD MODEL
figure;
subplot(2,1,2)
plot(t,y,'LineWidth',1.5,'MarkerSize',18);
legend('Podatni na zakażenie','Zainfekowani, ale bezobjawowi i niezaraźliwi','Zakażeni i zaraźliwi','Wyzdrowiali lub odporni','Zmarli','Location','Best')
xlabel('Days after March 7,2020');
ylabel('Population');
title(['Predicated spread of COVID-19 in Poland ',  ' (beta=', num2str(beta),')']);
grid on;
grid minor;
set(gca, 'FontSize', 15);

%% Symulacja Monte Carlo dla losowych wartości beta i death_rate


num_simulations = 100;  % Liczba symulacji Monte Carlo
results = zeros(num_simulations, length(predictTime), 5); % Macierz do przechowywania wyników

for sim = 1:num_simulations
    % Generowanie losowych parametrów
    [beta, death_rate] = generateRandomParameters();
    
    % Rozwiązanie równań ODE dla bieżących parametrów
    [t,y] = ode45(@(t,y) odefunc(t,y,beta), predictTime, y0);
    
    % Zapis wyników do macierzy wyników
    results(sim, :, :) = y;
end

% Wykresy Monte Carlo dla średnich wyników
mean_results = mean(results, 1);
std_dev_results = std(results, 1);


subplot(2,1,1)
plot(predictTime, squeeze(mean_results(:, :, 1)), 'b', 'LineWidth', 1.5);
hold on;
plot(predictTime, squeeze(mean_results(:, :, 2)), 'g', 'LineWidth', 1.5);
plot(predictTime, squeeze(mean_results(:, :, 3)), 'r', 'LineWidth', 1.5);
plot(predictTime, squeeze(mean_results(:, :, 4)), 'c', 'LineWidth', 1.5);
plot(predictTime, squeeze(mean_results(:, :, 5)), 'm', 'LineWidth', 1.5);

xlabel('Days after March 7, 2020');
ylabel('Average Population');
legend('Podatni na zakażenie','Zainfekowani, ale bezobjawowi i niezaraźliwi','Zakażeni i zaraźliwi','Wyzdrowiali lub odporni','Zmarli','Location','Best')
title('Average Predicted Spread of COVID-19 in Poland (Monte Carlo)');
grid on;
grid minor;
set(gca,'FontSize',15);



