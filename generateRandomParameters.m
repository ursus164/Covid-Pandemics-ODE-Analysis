function [beta_random, death_rate_random] = generateRandomParameters()
    % Zakresy parametrów
    R0_min = 1.0; R0_max = 8.0;     % Przykładowy zakres dla R0
    death_rate_min = 0.01; death_rate_max = 0.07; % Przykładowy zakres dla współczynnika śmiertelności

    % Generowanie losowego R0
    R0_random = R0_min + (R0_max - R0_min) * rand();

    % Obliczenie beta na podstawie losowego R0
    N = 37.75e6; % Populacja
    duration = 7; % Średnia długość infekcji
    beta_random = R0_random / (N * duration);

    % Generowanie losowego współczynnika śmiertelności
    death_rate_random = death_rate_min + (death_rate_max - death_rate_min) * rand();
end