%--------------------------------------------------------------------------
% IX1303-VT2023: PROJEKTUPPGIFT 3, Streckgubben av Seema Bashir
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clearvars, clc

filename = 'dashman.gif';
TimePerFrame = 0.05;
BoundingBox = [-1,1,-1,1]*14; % Om gubben hamnar utanför skärmen, så ändra här!
NumberOfTimeSteps = 50;

%------------------
% SKAPA MATRISERNA
%------------------
%----- SKRIV KOD: Skapa den matris som beskriver den efterfrågade avbildningen -----
% Skapa matrisen för den efterfrågade avbildningen

% transformationsmatrisen skapas
rotationMatrix = @(theta) [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
translationMatrix = @(dx, dy) [1, 0, dx; 0, 1, dy; 0, 0, 1];
scalingMatrix = @(scale) [scale, 0, 0; 0, scale, 0; 0, 0, 1];

% värden för rotation, translation och skalning bestämns
rotationAngle = pi/8;
dx = 0; 
dy = -15/NumberOfTimeSteps; % Translaterar uppåt

% Förstoring 1 till 4 gånger
scale = 1 + (3 / NumberOfTimeSteps); 

% transformationsmatrisem skapas 
rotationMatrix = rotationMatrix(rotationAngle);
translationMatrix = translationMatrix(dx, dy);
scalingMatrix = scalingMatrix(scale);

% Sammansatta transformationsmatrisen skapas
A = scalingMatrix * rotationMatrix * translationMatrix;


%------------------------------
% SKAPA STRECKGUBBEN, DASH-MAN
%------------------------------

D=DashMan();

%-----------------------------------
% SKAPA FÖRSTA BILDEN I ANIMERINGEN
%-----------------------------------
figure(1);
clf; hold on;
axis equal
axis(BoundingBox)
set(gca,'visible','off')

plotDashMan(D); % Här ritar vi Dash-man som han ser ut från början
addFrameToGif(filename, 1, TimePerFrame)

%-----------------------------------------------------
% Bilder i animering loopas, från 2 till 50
%-----------------------------------------------------
for i = 2:50
%----- SKRIV KOD: Transformera alla DASH-MAN's kroppsdelar -----
% Här ska du uppdatera punkter i D, dvs alla punkter i huvudet, kroppen osv.

% huvudetet tranaformeras
D.head = A * D.head;

% munnen tranaformeras
D.mouth = A * D.mouth;

% kroppen tranaformeras
D.body = A * D.body;

% benen tranaformeras
D.legs = A * D.legs;

% armarna tranaformeras
D.arms = A * D.arms;


  hold off
  plotDashMan(D); % Här ritar vi Dash-man som han ser ut efter transformationen
  axis equal
  axis(BoundingBox)
  set(gca,'visible','off')
  addFrameToGif(filename, i, TimePerFrame)
end


% Frågor:
% 1.Varför innehåller sista raden i D.head bara ettor?

% SVAR: Den sista raden i D.head består enbart av ettor, vilket är avsiktligt 
% gjort för att representera den homogena koordinaten. Inom geometriska 
% transformationer utnyttjas homogena koordinater för att underlätta och 
% effektivisera matematiska operationer. Genom att inkludera en homogen 
% koordinat som är konstant och lika med ett i den sista raden kan man på
% ett enklare sätt genomföra olika transformationsoperationer. Detta gör 
% det möjligt att utföra geometriska manipulationer på ett mer
% sammanhängande och effektivt sätt, vilket är särskilt användbart inom
% områden som datorgrafik och bildbehandling. Homogena koordinater ger en 
% förenklad och enhetlig representation av geometriska objekt och deras 
% transformationer, vilket underlättar beräkningar och analyser inom dessa 
% områden.

% 2.Beskriv skillnaden i gubbens rörelse över flera varv (d.v.s banan gubben rör sig längs) när man translaterar uppåt, neråt, åt höger eller vänster?

% SVAR:  Skillnaden i gubbens rörelse beror på riktningen av translationen.
% När gubben translateras uppåt förväntas dess rörelse följa en uppåtgående
% bana längs banan. Å andra sidan, när gubben translateras neråt, förväntas
% dess rörelse vara en nedåtgående rörelse längs banan. På liknande sätt
% förväntas en translation åt höger eller vänster resultera i en 
% sidledsförflyttning åt höger eller vänster längs banan.
% Detta samband mellan riktningen på translationen och rörelsen längs
% banan gör att gubben anpassar sin rörelse enligt translationen
% och skapar en naturlig och konsekvent förflyttning längs banan i enlighet
% med de angivna riktningsförändringarna.



% 3.Om man flyttar gubben en sträcka dx=0.1 per steg, och vi tar 50 steg med kombinerad translation och rotation, varför har gubben inte flyttats 50*0.1 åt höger?

% SVAR: Gubben har inte förflyttats exakt 50 * 0.1 enheter åt höger på 
% grund av rotationseffekten. Rotationen kan påverka riktningen på gubbens
% rörelse och resultera i en avvikelse från en ren horisontell förflyttning.
% Denna avvikelse kan leda till att gubben följer en bana som inte är 
% helt horisontell. Rotationen inför en viss vinkelkomponent som påverkar
% rörelseriktningen och kan resultera i en diagonal eller böjd rörelse 
% snarare än en ren horisontell förflyttning. 


