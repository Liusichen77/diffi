function   [luW, epis, num]=lupeso(X)
% MATRIZ DOS PESOS W                          Original date: 12/09/12
% Objetivo: Criar calcula a matriz de similaridades W a partir da matriz dos dados X. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   CÁLCULO DO W COM NÚCLEO GAUSSIANO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%m=size(X,1);% Nº de linhas do conjunto de dados X, dimensão do espaço onde 
% os dados estão originalmente, só tem influência no cálculo de W
n=size(X,2);% Nº de nós do grafo, nº de colunas da matriz dos dados X, nº 
% de dados, cada dado será um nó do grafo

luW=zeros(n);                 % Só prealocação para aumentar velocidade

% Chamo a function ludist (ou ludistvet, para o caso de X ser vetor) para 
% calcular a matriz das distâncias euclidianas entre as colunas (ou entre 
% os elemento do vetor X) de X

num=-ludist(X); % num => matriz simétrica das distâncias entre as colunas de X

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % AQUI usei a  maior distância
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epis = max(max(-num)); % Quero que epissolon sj a mor distância entre as colunas de X
%epis = (max(max(-num)))/2; % Quero que epissolon sj a mor distância entre as colunas de X

for i=1:(n-1) % Como j começa em i+1 e termina em n, i terminará antes de n        
 for j=i+1:n
     luW(i,j)=exp(num(i,j)/epis); % Este luW com epis= mir2 está fazendo diffi análaga a identidade
     luW(j,i)=luW(i,j);   % luW é simétrica
  end 
end

%Só para fazer a diagonal da matriz de adjacência que será sempre 1
for i=1:n
    luW(i,i)=1;
end

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
