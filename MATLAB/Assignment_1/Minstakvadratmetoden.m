%--------------------------------------------------------------------------
% IX1303-VT2023: PROJEKTUPPGIFT 1, Linjära ekvationssystem av Seema Bashir
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clearvars, clc

% List över antalet frihetsgrader (värden på n) som ska studeras.
% Här har vi alltså fyra olika fall som ska studeras, först n=1, sen n=30,
% sen n=300 och till sist n=3000.
nList = [3, 30, 300, 3000];

% Loop över de olika frihetsgraderna.
% Loopen innebär att koden mellan "for" och "end" kommer att köras 4 gånger
% (eftersom length(nList)=4), först med i=1, sen i=2, i=3 och i=4.
for i=1:length(nList)

  % Här skapar vi en variabel n. Värdet på n är 3 först gången vi går
  % igenom loopen, sen 30, 300 och 3000.
  n=nList(i);

  %----- SKRIV KOD: Skapa nxn matrisen A -----
  I = eye(n); % Detta är en Identitsmatris som är n x m 
  R = rand(n); % Detta är en slumpmässigt matris som har storlek n x m 

  % Sätter initila gränser för den binära sökningen
  lowerBound = 0;
  upperBound = 1;
  tolerance = 1e-6; % Detta motsvarar tolerence för konvergence

  while (upperBound - lowerBound) > tolerance
    k = (lowerBound + upperBound) / 2; % Beräknar mittpunkten av gränserna
    C = k * R; % Beräknar matrisen k med aktuella värdet på k 
    colSum = sum(C, 1); % Beräknar summar av kolumnerna i matrisen C
    if any(colSum >= 1)
        upperBound = k; % Justerar övre gränsen 
    else
        lowerBound = k; % Justerar lägre gränsen 
    end
  end

      disp("Max colsum: " + max(sum(C, 1))); % Beräknar maximala kolumnsumma
      k = k * 0.5; % Minskar k med en faktor 2 
      C = k * R; % Uppdaterar C
      A = I - C;  % skapar slutliga matrisen 
      
      %Test%
      %disp("colSum = " + colSum);
      disp("Final k = " + k);
      detA = det(A);  % Determinanten av matrisen A beräknas 
      disp("det(A) = " + detA); % De förväntade resultat är att det(A) inte är lika med noll, efterson A förväntas att vara invertible
      

  % Fråga: 
  %   Här är A=I-C, där C=kR och R är en matris med slumptal
  %   mellan 0 och 1. För vilka värden på k är kolumnsumman
  %   alltid (för alla möjliga slumptal) mindre är 1?
  % Svar: 
  % Matrisen R består av slumpmässiga tal mellan 0 och 1, därför kommer
  % kolumnsummorna för varje kolumn i R vara begränsade till intervallet
  % mellan 0 och 1. För att säkerställa att kolumnsumman i matrisen C är 
  % alltid är mindre än 1, måste värdet på k väljs att vara större än 0
  % och mindre än 1. Med andra ord det gäller att 0 <k <1.

  %----- SKRIV KOD:Skapa kolumn-vektorn b -----
  b = rand(n,1);  % vektorns storlek representeras av n , det vill säga n x 1
                  % En vektor med tal mellan 0 och 1 är "b = 0 + (1-0) * rand(3,1)" 

  %----- SKRIV KOD: Lös ekvationssystemet med mldivide -----
  tic;      % tiden startas
  x = A\b;  % detta löser ekvationssytemet
  T_mldivide(i) = toc; % tiden sparas som det tog att lösa ekvationen
  
  %----- SKRIV KOD: Lös ekvationssystemet med inv -----
  tic;            % tiden startas 
  x = inv(A) * b; % detta löser ekvationssystemet
  T_inv(i) = toc; % tiden sparas som det tog att lösa ekvationen 

  
  %----- SKRIV KOD: Jämför lösningarna från mldivide och inv -----
  diff = norm((A\b) - (inv(A) * b)); % skillnade beräknas mellan lösningarna

end

%----- SKRIV KOD: Rita första figuren -----
% skapa den första grafen
figure
plot(nList, T_mldivide, 'o-', 'LineWidth', 2)
hold on
plot(nList, T_inv, 's--', 'LineWidth', 2)
xlabel('Antal obekanta')
ylabel('Tid (s)')
legend('mldivide', 'inv')
title('Tid att lösa ekvationssystem')
grid on
%----- SKRIV KOD: Rita andra figuren -----
% skapa den andra grafen med log-log skala
figure
loglog(nList, T_mldivide, 'o-', 'LineWidth', 2)
hold on
loglog(nList, T_inv, 's--', 'LineWidth', 2)
xlabel('Antal obekanta')
ylabel('Tid (s)')
legend('mldivide', 'inv')
title('Tid att lösa ekvationssystem med log-log skala')
grid on

% sätt x- och y-axlarna till log-skala
set(gca,'xscale','log')
set(gca,'yscale','log')



% Frågor:
% 1. Antag att du ska lösa ett problem med tre obekanta en eller ett par gånger. Hur väljer du metod? Är det viktigt att välja rätt metod?

% SVAR: Vid en situation där antalet obekanta i problemet är begränsat, till
% exempel tre, finns det möglihet att välja mellan två olika metoder för
% att lösa det. Nämligen inverteringsetoden och mldivide-operatorn. Därmed
% kan man völja den som ger en mer exakt lösning. Å andra sidan om behovet
% endast innefattar att lösa problemet en eller ett par gånger, kan vilken
% metod användas utan att ha en betydande påverkan på resultatet.

% 2. Antag att du ska lösa ett problem med tre obekanta 10 000 gånger. Hur väljer du metod? Är det viktigt att välja rätt metod?

% SVAR: Vid upprepade lösningar av ett problem med tre obekanta,
% som behöver utföras 10 000 gånger, blir det viktigt att välja den mest 
% effektiva metoden för att spara tid. I detta scenario är det troligtvis
% fördelaktigt att använda inverteringsmetoden,baserat på resultaten som
% visar att den tenderar att vara snabbare än mldivide-metoden vid situationer
% med färre obekanta. Genom att välja inverteringsmetoden kan man förvänta 
% sig en snabbare lösning och därigenom optimera tiden. 

% 3. Antag att du ska lösa ett problem med 3000 obekanta en eller ett par gånger. Hur väljer du metod? Är det viktigt att välja rätt metod?

% SVAR: I denna situation är det av största vikt att välja den metod som
% kan ge de mest exakta och pålitliga resultaten. 
% Det är betydelsefullt att noggrant överväga vilken metod som är mest
% lämplig eftersom olika metoder kan erbjuda olika nivåer av noggrannhet
% och stabilitet, vilket är beroende av egenskaperna hos det specifika problemet.
% Med tanke på dessa faktorer kan det vara fördelaktigt att välja mldivide-metoden 
% som ett alternativ. En anledning till detta är att mldivide-metoden tenderar
% att vara snabbare än inverteringsmetoden när det gäller problem med ett 
% stort antal obekanta. Genom att välja mldivide-metoden kan man således 
% uppnå både önskad exakthet och tidsmässig effektivitet i processen.

% 4. Kör om alla räkningar tre gånger. Varför får du olika resultat varje gång du kör programmet?

% SVAR: Eftersom R-matrisen genereras slumpmässigt kommer den att variera 
% mellan olika körningar. Detta leder till variationer i matriserna A 
% och vektorn b, som också genereras av slumpmässiga tal vid varje körning. 
% Dessa variationer kommer att påverka både lösningarna och beräkningstiderna.

% 5. Hur stor är den relativa skillnaden i beräkningstid mellan de två metoderna för 3000 obekanta?

% SVAR: För att beräkna den relativa skillnaden i beräkningstid mellan
% mldivide och inv för 3000 obekanta kan vi använda kvoten mellan tiderna 
% för mldivide och inv. 
% Vi kan beräkna detta som:

rel_diff = T_mldivide(4)/T_inv(4) - 1;  % får relativa skillnaden i procent
disp(rel_diff);

% För att illustrera den relativa skillnaden i beräkningstid mellan mldivide 
% och inv för 3000 obekanta kan vi använda värdet "4" som representerar
% det sista värdet i listan "nList". Det är viktigt att notera att den faktiska 
% relativa skillnaden i beräkningstid kan variera från körning till körning 
% på grund av slumpmässiga variationer. 
% Det innebär att resultaten kan vara olika varje gång programmet 
% körs på grund av faktorer utanför vår kontroll.


% Egen notering : 
% Mldivide-operatorn () är en kraftfull inbyggd funktion i MATLAB 
% som används för att lösa ekvationssystem. Den använder sig av 
% LU-faktorisering eller QR-faktorisering för att effektivt och noggrant 
% lösa systemet. Genom att tillhandahålla en matris och en vektor kan
% mldivide-operatorn automatiskt beräkna lösningen utan att behöva 
% explicita inverteringar eller andra komplicerade operationer.
% Detta gör den till en användbar och tidsbesparande funktion 
% inom MATLAB-miljön.


