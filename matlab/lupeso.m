function   [luW, epis, num]=lupeso(X)
%[luW, epis]=lupeso(X)
% Se quiser que apareça a resposta numérica para comparar é só colocar 
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
%                   CÁLCULO DO W COM NÚCLEO GAUSSIANO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%m=size(X,1);% Nº de linhas do conjunto de dados X, dimensão do espaço onde 
% os dados estão originalmente, só tem influência no cálculo de W
n=size(X,2);% Nº de nós do grafo, nº de colunas da matriz dos dados X, nº 
% de dados, cada dado será um nó do grafo

% Criar a matriz simétrica dos pesos W. 
luW=zeros(n);                 % Só prealocação para aumentar velocidade

% Chamo a function ludist (ou ludistvet, para o caso de X ser vetor) para 
% calcular a matriz das distâncias euclidianas entre as colunas (ou entre 
% os elemento do vetor X) de X

num=-ludist(X); % num => matriz simétrica das distâncias entre as colunas de X

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % AQUI usei a  maior distância
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % [mor1, ind1]=max(-num); % mor1 é uma linha com os maiores nºs de cada coluna de -num
% % [mor2, ind2]=max(mor1); % mor2 é o nº maior da matriz -num
% % mor_linha = ind1(1,ind2); % ind1 é uma linha formada pelos nºs das linhas correspondentes aos maiores nºs da matriz -num
% % % retirados de cada coluna, quero saber apenas a linha correspondente ao maior nº de toda a matriz -num.
% % mor_coluna=ind2; % é a coluna correspondente ao maior nº da matriz -num
% % maior_distancia=mor2;
% % epis=mor2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AQUI usei a menor  distância não nula
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%epis=lumirnaonulo(-num); %Chamei a fç que calcula a menor distância não nula nas condições desta matriz

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % AQUI usei a menor  distância
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % [mir1, ind1]=min(-num); % mir1 é uma linha com os menores nºs de cada coluna de -num
% % [mir2, ind2]=min(mir1); % mir2 é o nº menor da matriz -num
% % mir_linha = ind1(1,ind2); % ind1 é uma linha formada pelos nºs das linhas correspondentes aos menores nºs da matriz -num
% % % retirados de cada coluna, quero saber apenas a linha correspondente ao menor nº de toda a matriz -num.
% % mir_coluna=ind2; % é a coluna correspondente ao menor nº da matriz -num
% % menor_distancia=mir2;
% % epis=mir2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%epis=100000;
%epis=lumirnaonulo(-num); % Função que calcula a menor distância não nula nas condições da matriz
epis = max(max(-num)); % Quero que epissolon sj a mor distância entre as colunas de X
%epis = (max(max(-num)))/2; % Quero que epissolon sj a mor distância entre as colunas de X
%epis = (max(max(-num)))/4; % Quero que epissolon sj a mor distância entre as colunas de X
%epis = (max(max(-num)))/16; % Quero que epissolon sj a mor distância entre as colunas de X
%epis = (max(max(-num)))/8; % Quero que epissolon sj a mor distância entre as colunas de X
%epis = (max(max(-num)))/(0.5)^2; % Quero que epissolon sj a mor distância entre as colunas de X
%epis = (max(max(-num)))/(0.5)^4; % Quero que epissolon sj a mor distância entre as colunas de X


%epis=n*max(max(-num)); % Função que calcula a menor distância não nula nas condições da matriz, n é o nº de nós do grafo
%epis=m*max(max(-num)); % Função que calcula a menor distância não nula nas condições da matriz, m é o nº de variáveis de cada nó
%%%%epis=log(1/m)*max(max(-num)); % Função que calcula a menor distância não nula nas condições da matriz, m é o nº de variáveis de cada nó
%epis=log(1/n)*max(max(-num)); % Função que calcula a menor distância não nula nas condições da matriz, m é o nº de variáveis de cada nó

%epis = sqrt(max(max(-num))); % Quero que epissolon sj a mor distância entre as colunas de X
%epis=sqrt(lumirnaonulo(-num)); % Função que calcula a menor distância não nula nas condições da matriz
%epis=0.0001;
%num=-ludistvet(X); % num => matriz simétrica das distâncias entre os elementos do vetor X
% Não consegui fazer para vetor
%%%%%epis= log(epis); % log é o logaritmo natural, ou sj, o que eu chamo de ln

for i=1:(n-1) % Como j começa em i+1 e termina em n, i terminará antes de n        
 for j=i+1:n
 %epis=mean([std(X(:,i)) std(X(:,j))]); % Mais uma tentativa para epis em 06/06/13,
 %mas os resultados ficaram ruins
     luW(i,j)=exp(num(i,j)/epis); % Este luW com epis= mir2 está fazendo diffi análaga a identidade
     %luW(i,j)=exp(num(i,j)/(-num(i,j))); % daria 1/e=0.3659 nas posições da matriz peso fora a diagonal
     %luW(i,j)=exp(num(i,j)/m); % considerei  epsilon como sendo m= nº de 
     %  linhas de X, pois este nº vai se perder depois que passamos a pensar
     % só no grafo e não mais nos pontos m-dimensionais. Cada coluna de X é
     % um nó do grafo e as linhas representam a dimensão de cada um dos
     % nós. Após tratarmos com a matriz de adjacência não será mais
     % importante esta dimensão, mas apenas a quantidade de colunas. Por
     % isso achei importante que este nº entrasse no cálculo de luW.
     % Se n é grande é pq o grafo tem muitos nós então os pesos entre as
     % arestas aumentam.
     luW(j,i)=luW(i,j);   % luW é simétrica
  end 
end

%Só para fazer a diagonal da matriz de adjacência que será sempre 1
for i=1:n
    luW(i,i)=1;
end
%peso_da_maior_distancia=luW(mor_linha, mor_coluna);
%peso_da_menor_distancia=luW(mir_linha, mir_coluna);
%luW

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     CÁLCULO DO W COM PRODUTO INTERNO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % n=size(X,2);% Nº de nós do grafo, nº de colunas da matriz dos dados X
% % 
% % % Criar a matriz simétrica dos pesos W. 
% % luW=zeros(n);                 % Só prealocação para aumentar velocidade
% % 
% % for i=1:n         
% %  for j=i+1:n
% %      luW(i,j)=dot(X(:,i),X(:,j)); 
% %      luW(j,i)=luW(i,j);
% %  end 
% % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Este comando é para ver a figura da matriz de luW.
% figure
% imshow(luW);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         TESTAR A SEMIPOSITIVIDADE DE  W
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A matriz mteste tb pode ser escrita como D^{1/2}*(inv(D)W)*inv(D^{1/2}) e
% portanto é similar a matriz de Markov da qual eu calculo os autovalores
% em diff map. Logo os autovalores de mteste serão os msms de inv(D)W.
% Se mteste tiver algum autovalor negativo então ela não será psd e
% portanto W tb não será contrariando nossas hipóteses iniciais. Não sei
% como criar um W que sj psd.

% Para fazer o teste tem que tirar o ponto e vírgula para saber quem é a
% matriz autalor dos autovalores de mteste.

% % % Chamo a function lugrau para calcular a matriz Degree
% % D= lugrau(luW);
% % mteste=inv(D^(1/2))*(luW)*inv(D^(1/2));
% % [autalor]=eig(mteste);
