%--------------------------------------------------------------------------
% IX1303-VT2023: PROJEKTUPPGIFT 2, CO2 mätning av Seema Bashir 
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clearvars, clc

%----- SKRIV KOD: Fyll i data-filens namn (ta med .csv, .txt, eller liknande) -----
filename="co2_data.csv";
TABLE=readtable(filename);

%----- SKRIV KOD: Fyll i namnen på de kolumner som innehåller tid och data (dvs byt ut XXXXXX) -----
% Namnen på dessa kolumner finns oftast i csv filen. Men, om ni har
% läst in tabellen TABLE kan du se listan av kolumner genom att skriva 
% "T.Properties.VariableNames" i kommand-prompten. 
% Notera att när man arbetar med data någon annan skapat krävs ofta lite
% detektivarbete för att förstå exakt vad alla värden beskriver!
T = [ TABLE.Date_1];  % T ska vara en vektor med tiden för olika C02 mätningar
y = [ TABLE.CO2 ];    % y ska vara en vektor med data från CO2 mätningar 
nan_idx = isnan(y) | isnan(T);
y_clean = y(~nan_idx & y > -99);
T_clean = T(~nan_idx & y > -99);

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(t) till en rät linje -----
% Rät linjens ekvation kan skrivas som  y = kx + m
% Där y representerar C02 data 
% Där x representerar tiden 

% En matris X sätts upp som innehåller ettor i första kolumnen
% Notera att (ettor motsvarar konstanttermen i ekvationen)
% och i andra kolumn är det tid-värden som kommer bli x-axeln
X = [ones(length(T_clean), 1), T_clean];

% Normal ekvations används för att räkna coefficienterna 
constant = (X' * X) \ (X' * y_clean);

% Ställer upp linjen ekvation 
m = constant(1);
k = constant(2);
y_fit = m + k*T_clean;

%----- SKRIV KOD: Rita både mätdata och anpassningen i samma graf. -----
figure
plot(T_clean, y_clean, '.', T_clean, y_fit, '-','LineWidth', 2)
xlabel('Tid')
ylabel('CO2')
legend('Mätdata', 'Linjär anpassning')

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(t) till ett andragradspolynom -----
% En matris X som inneåller ettor i först kolumnen
% (ettor motsvarar konstanttermen i polynomet)
% Andra kolumnen består av tid-värden. Dessutom består tredje kolumn 
% är tid-värdens upphöjt till två. (Notera det är en andragradsekvation)
X2 = [ones(length(T_clean), 1), T_clean, T_clean.^2];

% Normal ekvationen används för att räkna ut koefficienterna
constant2 = (X2' * X2) \ (X2' * y_clean);

% Andragradspolynomet anpassas:
a = constant2(1);
b = constant2(2);
c = constant2(3);
y_fit2 = a + b*T_clean + c*T_clean.^2;

%----- SKRIV KOD: Rita både mätdata och anpassningen i samma graf. -----
figure
plot(T_clean, y_clean, '.', T_clean, y_fit2, '-','LineWidth', 2)
xlabel('Tid')
ylabel('CO2')
legend('Mätdata', 'Andragradspolynom anpassning')

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(t) till ett tredjegradspolynom -----
% Sätter upp matrisen X som innehåller ettor i första kolumn (ettor motsvarar konstanttermen i polynomet)
% och i andra kolumn är det tid-värden och i tredje kolumn 
% blir det tid-värden upphöjt till två och i den fjärde kolumn
% blir det tid-värden upphöjt till tre - då det är tredjegradsekvation
X3 = [ones(length(T_clean), 1), T_clean, T_clean.^2, T_clean.^3];

% Normal ekvationen används för att räkna ut koefficienterna
constant3 = (X3' * X3) \ (X3' * y_clean);

% tredgepolynomet anspassas:
a = constant3(1);
b = constant3(2);
c = constant3(3);
d = constant3(4);
y_fit3 = a + b*T_clean + c*T_clean.^2 + d*T_clean.^3;

%----- SKRIV KOD: Rita både mätdata och anpassningen i samma graf. -----
figure
plot(T_clean, y_clean, '.', T_clean, y_fit3, '-','LineWidth', 2)
xlabel('Tid')
ylabel('CO2')
legend('Mätdata', 'Tredjegradspolynom anpassning')

% _____________________________________________________________________________________________________

% Frågor:
% 1. Beskriv med egna ord hur de tre kurvorna beskriver. 
% Framför allt, blir lösningen lite eller mycket bättre när vi går från en rät linje till en andragradsfunktion? 
% Blir den mycket bättre när vi går från en andragradsfunktion till en tredjegradsfunktion?

% SVAR: Det är alltså linjär anpassning av mätdata för koldioxid (CO2) över en given tidsperiod.
% Den räta linjen representerar en modell som beskriver förändringen av CO2-nivåerna 
% och visar om det sker en konstant ökning eller minskning över tiden. 
% Genom att använda linjär regression kan man hitta den bästa passningen 
% för att linjärt approximera CO2-data och få en övergripande bild av hur CO2-nivåerna 
% utvecklar sig över tid. Detta ger en användbar representation av CO2-trenden 
% och kan bidra till att förstå och analysera den övergripande förändringen 
% i CO2-nivåerna.

% Andragradspolynom: Ett andragradspolynom är en mer avancerad anpassning 
% av CO2-mätdata över tiden, som ger en kurva med en mer böjd form. 
% Genom att använda ett andragradspolynom kan man beskriva förändringen 
% i CO2-nivåerna på ett mer komplext sätt än en enkel linjär modell.
% Denna typ av polynom tar hänsyn till faktorer som kan ge upphov till 
% icke-konstant förändring, till exempel i procentuella termer eller 
% andra komplexa mönster. Genom att använda andragradspolynomet kan man
% få en bättre anpassning till CO2-data och därmed få en mer detaljerad 
% och noggrann beskrivning av förändringen i CO2-nivåerna över tiden.

% Tredjegradspolynom: Ett tredjegradspolynom är en ännu mer sofistikerad 
% anpassning av CO2-mätdata över tiden, vilket ger en kurva med ännu mer böjd form.
% Genom att använda ett tredjegradspolynom kan man beskriva förändringen 
% i CO2-nivåerna på ett ännu mer komplex och icke-linjärt sätt över tiden. 
% Detta innebär att polynomet tar hänsyn till ytterligare faktorer och mönster 
% som kan påverka CO2-nivåerna och ger en mer detaljerad representation 
% av den verkliga förändringen. Genom att använda ett tredjegradspolynom 
% kan man få en ännu mer precisa och noggranna beskrivning av CO2-nivåernas 
% utveckling över tid, vilket är särskilt värdefullt vid analyser och prognoser 
% av klimatförändringar och dess påverkan på miljön.


% När vi övergår från en rät linje till ett andragradspolynom förbättras
% lösningen avsevärt,eftersom det andragradsanpassade polynomet 
% har förmågan att beskriva mer komplexa former än en enkel linje. 
% Skillnaden mellan ett andragradspolynom och ett tredjegradspolynom 
% blir dock mindre betydande. Genom att övergå från ett andragradspolynom 
% till ett tredjegradspolynom får vi en något mer böjd kurva,
% men det är viktigt att notera att det tredjegradspolynomet kan vara 
% överanpassat till de givna mätdata. Det kan innebära att det inte nödvändigtvis 
% kan generalisera korrekt utanför intervallet för de givna mätningarna.
% Det är därför viktigt att vara medveten om eventuell överanpassning 
% och noggrant bedöma lämpligheten av den valda polynomgraden 
% för att få en trovärdig och generaliserbar lösning.

% ___________________________________________________________________________________________________

% 2. Kan man använda dessa anpassningar för att uppskatta utsläppen om 2 år? Motivera ditt svar.

% SVAR: Nej, dessa anpassningar kan inte tillförlitligt användas för att
% uppskatta utsläppen om 2 år. Anpassningarna är baserade på befintliga CO2-mätningar 
% och kan inte nödvändigtvis extrapolera på ett tillförlitligt sätt utanför intervallet
% för de tillgängliga mätningarna. Dessutom, när man granskar grafen,
% är det tydligt att det finns en betydande skillnad mellan de uppskattade datavärdena
% och de verkliga datavärdena. Detta indikerar att anpassningarna inte är tillräckligt 
% noggranna eller pålitliga för att förutsäga CO2-utsläppen med tillförlitlighet för framtiden. 
% För att göra mer tillförlitliga uppskattningar för kommande år bör man använda sig av mer specifika och aktuella data samt beakta andra relevanta faktorer som kan påverka CO2-utsläppen.

%_______________________________________________________________________________________________________

% 3. Kan man använda dessa anpassningar för att uppskatta utsläppen om 50 år? Motivera ditt svar.

% SVAR: Nej, dessa anpassningar kan inte tillförlitligt användas för att
% uppskatta utsläppen om 50 år på ett tillförlitligt sätt. Anpassningarna 
% är baserade på befintliga CO2-mätningar och kan inte förutsäga framtida 
% förändringar i utsläppsmönster på ett tillförlitligt sätt. Det finns 
% olika faktorer som kan påverka utsläppen under en så lång tidsperiod,
% inklusive politiska beslut, teknologiska framsteg och 
% samhällsförändringar. För att göra en tillförlitlig prognos om utsläppen
% om 50 år krävs mer sofistikerade modeller och noggranna analyser av dessa 
% påverkande faktorer. Det är viktigt att ta hänsyn till den osäkerhet och
% komplexitet som är förknippad med att göra prognoser på så lång sikt 
% och att använda mer omfattande och aktuell information för att få en mer
% tillförlitlig uppskattning av framtida utsläpp.







