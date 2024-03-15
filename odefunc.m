% Modelowanie równań różniczkowych dla modelu SEIRD

function dydt = odefunc(t,y,beta)

death_rate = 0.034      % Współczynnik smiertelności (dane dla polski - Marzec 2020)) -> 3.4%

pre_infec = 5.2;        % ilość dni w jakiej osoba przechodzi z grupy E (narażeni) do grupy I (zainfekowani)
f = 1/pre_infec;        % szybkość przejścia 

duration = 7;      % ilość dni jakie spędza osoba w grupie I     
r = 1/duration;     % szybkość wyzdrowienia / śmierci

S = y(1);   % wektory poszczególnych grup
E = y(2);
I = y(3);

dS = -beta*I.*S;            % zmiana liczby podatnych (grupa S) -> maleje w miarę postępu epidemii
dE = beta*I.*S-f.*E;        % zmiana liczby narażonych (grupa E) -> wzrasta przez kontakt z zakażonymi, i maleje po przejsciu do grupy zainfekowanych
dI = f*E-r*I;               % zmiana liczby ozdrowiałych
dR = r*(1-death_rate)*I;    % zmiana liczby zmarłych
dD = (death_rate)*r*I;

dydt = [dS;dE;dI;dR;dD];    % wektor pochodnych dla każdej grupy z modelu
end