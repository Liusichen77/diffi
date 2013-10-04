function   [luW, epis, num]=lupeso(X)
%[luW, epis]=lupeso(X)
% Se quiser que apare�a a resposta num�rica para comparar � s� colocar 
% luW = lupeso(X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATRIZ DOS PESOS W                          Data: 12/09/12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nome do Programa: lupeso.m
% 
% Objetivo: Criar uma function que calcule a matriz dos pesos W a partir 
% da matriz dos dados X. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   C�LCULO DO W COM N�CLEO GAUSSIANO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%m=size(X,1);% N� de linhas do conjunto de dados X, dimens�o do espa�o onde 
% os dados est�o originalmente, s� tem influ�ncia no c�lculo de W
n=size(X,2);% N� de n�s do grafo, n� de colunas da matriz dos dados X, n� 
% de dados, cada dado ser� um n� do grafo

% Criar a matriz sim�trica dos pesos W. 
luW=zeros(n);                 % S� prealoca��o para aumentar velocidade

% Chamo a function ludist (ou ludistvet, para o caso de X ser vetor) para 
% calcular a matriz das dist�ncias euclidianas entre as colunas (ou entre 
% os elemento do vetor X) de X

num=-ludist(X); % num => matriz sim�trica das dist�ncias entre as colunas de X

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % AQUI usei a  maior dist�ncia
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % [mor1, ind1]=max(-num); % mor1 � uma linha com os maiores n�s de cada coluna de -num
% % [mor2, ind2]=max(mor1); % mor2 � o n� maior da matriz -num
% % mor_linha = ind1(1,ind2); % ind1 � uma linha formada pelos n�s das linhas correspondentes aos maiores n�s da matriz -num
% % % retirados de cada coluna, quero saber apenas a linha correspondente ao maior n� de toda a matriz -num.
% % mor_coluna=ind2; % � a coluna correspondente ao maior n� da matriz -num
% % maior_distancia=mor2;
% % epis=mor2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AQUI usei a menor  dist�ncia n�o nula
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%epis=lumirnaonulo(-num); %Chamei a f� que calcula a menor dist�ncia n�o nula nas condi��es desta matriz

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % AQUI usei a menor  dist�ncia
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % [mir1, ind1]=min(-num); % mir1 � uma linha com os menores n�s de cada coluna de -num
% % [mir2, ind2]=min(mir1); % mir2 � o n� menor da matriz -num
% % mir_linha = ind1(1,ind2); % ind1 � uma linha formada pelos n�s das linhas correspondentes aos menores n�s da matriz -num
% % % retirados de cada coluna, quero saber apenas a linha correspondente ao menor n� de toda a matriz -num.
% % mir_coluna=ind2; % � a coluna correspondente ao menor n� da matriz -num
% % menor_distancia=mir2;
% % epis=mir2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%epis=100000;
%epis=lumirnaonulo(-num); % Fun��o que calcula a menor dist�ncia n�o nula nas condi��es da matriz
epis = max(max(-num)); % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis = (max(max(-num)))/2; % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis = (max(max(-num)))/4; % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis = (max(max(-num)))/16; % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis = (max(max(-num)))/8; % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis = (max(max(-num)))/(0.5)^2; % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis = (max(max(-num)))/(0.5)^4; % Quero que epissolon sj a mor dist�ncia entre as colunas de X


%epis=n*max(max(-num)); % Fun��o que calcula a menor dist�ncia n�o nula nas condi��es da matriz, n � o n� de n�s do grafo
%epis=m*max(max(-num)); % Fun��o que calcula a menor dist�ncia n�o nula nas condi��es da matriz, m � o n� de vari�veis de cada n�
%%%%epis=log(1/m)*max(max(-num)); % Fun��o que calcula a menor dist�ncia n�o nula nas condi��es da matriz, m � o n� de vari�veis de cada n�
%epis=log(1/n)*max(max(-num)); % Fun��o que calcula a menor dist�ncia n�o nula nas condi��es da matriz, m � o n� de vari�veis de cada n�

%epis = sqrt(max(max(-num))); % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis=sqrt(lumirnaonulo(-num)); % Fun��o que calcula a menor dist�ncia n�o nula nas condi��es da matriz
%epis=0.0001;
%num=-ludistvet(X); % num => matriz sim�trica das dist�ncias entre os elementos do vetor X
% N�o consegui fazer para vetor
%%%%%epis= log(epis); % log � o logaritmo natural, ou sj, o que eu chamo de ln

for i=1:(n-1) % Como j come�a em i+1 e termina em n, i terminar� antes de n        
 for j=i+1:n
 %epis=mean([std(X(:,i)) std(X(:,j))]); % Mais uma tentativa para epis em 06/06/13,
 %mas os resultados ficaram ruins
     luW(i,j)=exp(num(i,j)/epis); % Este luW com epis= mir2 est� fazendo diffi an�laga a identidade
     %luW(i,j)=exp(num(i,j)/(-num(i,j))); % daria 1/e=0.3659 nas posi��es da matriz peso fora a diagonal
     %luW(i,j)=exp(num(i,j)/m); % considerei  epsilon como sendo m= n� de 
     %  linhas de X, pois este n� vai se perder depois que passamos a pensar
     % s� no grafo e n�o mais nos pontos m-dimensionais. Cada coluna de X �
     % um n� do grafo e as linhas representam a dimens�o de cada um dos
     % n�s. Ap�s tratarmos com a matriz de adjac�ncia n�o ser� mais
     % importante esta dimens�o, mas apenas a quantidade de colunas. Por
     % isso achei importante que este n� entrasse no c�lculo de luW.
     % Se n � grande � pq o grafo tem muitos n�s ent�o os pesos entre as
     % arestas aumentam.
     luW(j,i)=luW(i,j);   % luW � sim�trica
  end 
end

%S� para fazer a diagonal da matriz de adjac�ncia que ser� sempre 1
for i=1:n
    luW(i,i)=1;
end
%peso_da_maior_distancia=luW(mor_linha, mor_coluna);
%peso_da_menor_distancia=luW(mir_linha, mir_coluna);
%luW

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     C�LCULO DO W COM PRODUTO INTERNO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % n=size(X,2);% N� de n�s do grafo, n� de colunas da matriz dos dados X
% % 
% % % Criar a matriz sim�trica dos pesos W. 
% % luW=zeros(n);                 % S� prealoca��o para aumentar velocidade
% % 
% % for i=1:n         
% %  for j=i+1:n
% %      luW(i,j)=dot(X(:,i),X(:,j)); 
% %      luW(j,i)=luW(i,j);
% %  end 
% % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Este comando � para ver a figura da matriz de luW.
% figure
% imshow(luW);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         TESTAR A SEMIPOSITIVIDADE DE  W
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A matriz mteste tb pode ser escrita como D^{1/2}*(inv(D)W)*inv(D^{1/2}) e
% portanto � similar a matriz de Markov da qual eu calculo os autovalores
% em diff map. Logo os autovalores de mteste ser�o os msms de inv(D)W.
% Se mteste tiver algum autovalor negativo ent�o ela n�o ser� psd e
% portanto W tb n�o ser� contrariando nossas hip�teses iniciais. N�o sei
% como criar um W que sj psd.

% Para fazer o teste tem que tirar o ponto e v�rgula para saber quem � a
% matriz autalor dos autovalores de mteste.

% % % Chamo a function lugrau para calcular a matriz Degree
% % D= lugrau(luW);
% % mteste=inv(D^(1/2))*(luW)*inv(D^(1/2));
% % [autalor]=eig(mteste);
