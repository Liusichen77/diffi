function   [luW, epis, num]=lupeso(X)
% MATRIZ DOS PESOS W                          Original date: 12/09/12
% Objetivo: Criar calcula a matriz de similaridades W a partir da matriz dos dados X. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   C�LCULO DO W COM N�CLEO GAUSSIANO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%m=size(X,1);% N� de linhas do conjunto de dados X, dimens�o do espa�o onde 
% os dados est�o originalmente, s� tem influ�ncia no c�lculo de W
n=size(X,2);% N� de n�s do grafo, n� de colunas da matriz dos dados X, n� 
% de dados, cada dado ser� um n� do grafo

luW=zeros(n);                 % S� prealoca��o para aumentar velocidade

% Chamo a function ludist (ou ludistvet, para o caso de X ser vetor) para 
% calcular a matriz das dist�ncias euclidianas entre as colunas (ou entre 
% os elemento do vetor X) de X

num=-ludist(X); % num => matriz sim�trica das dist�ncias entre as colunas de X

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % AQUI usei a  maior dist�ncia
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epis = max(max(-num)); % Quero que epissolon sj a mor dist�ncia entre as colunas de X
%epis = (max(max(-num)))/2; % Quero que epissolon sj a mor dist�ncia entre as colunas de X

for i=1:(n-1) % Como j come�a em i+1 e termina em n, i terminar� antes de n        
 for j=i+1:n
     luW(i,j)=exp(num(i,j)/epis); % Este luW com epis= mir2 est� fazendo diffi an�laga a identidade
     luW(j,i)=luW(i,j);   % luW � sim�trica
  end 
end

%S� para fazer a diagonal da matriz de adjac�ncia que ser� sempre 1
for i=1:n
    luW(i,i)=1;
end

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
