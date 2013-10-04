
function dista  = ludist(X)
% Esta fun��o calcula a dist�ncia euclidiana entre as colunas de uma matriz X dada 
% Data: 09/set/12,   Programador: L�cia 

% Descri��o das mudan�as: c�digo original. 


n=size(X,2);% N� de n�s do grafo, n� de colunas da matriz dos dados X, n� 
% de dados, cada dado ser� um n� do grafo

dista=zeros(n);     % S� prealoca��o para aumentar velocidade

% Calcular as dist�ncias entre os vetores coluna da matriz X
for k=1:(n-1)     % O produto vai at� o n� total de dados menos 1
  for i=k+1:n      % A coluna � um a mais do que a linha
      
    % A matriz dist guarda na posi��o (k,i) a dist�ncia do vetor X(:,k)para 
    % o vetor X(:,i)(Dist�ncia entre a k-�sima e i-�sima colunas da matriz X) 
     
    %dista(k,i)=sqrt(dot(X(:,k)-X(:,i),X(:,k)-X(:,i)));
       %        OU  
    aux=X(:,k)-X(:,i); % Auxiliar s� para economizar mem�ria tempor�ria
    dista(k,i)=dot(aux,aux); % Dist�ncia ao quadrado que � utilizada no peso
    
    dista(i,k)= dista(k,i);
      
  end
end
dista(n,:)=(dista(:,n))';
