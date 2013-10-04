
function dista  = ludist(X)
% Esta função calcula a distância euclidiana entre as colunas de uma matriz X dada 
% Data: 09/set/12,   Programador: Lúcia 

% Descrição das mudanças: código original. 


n=size(X,2);% Nº de nós do grafo, nº de colunas da matriz dos dados X, nº 
% de dados, cada dado será um nó do grafo

dista=zeros(n);     % Só prealocação para aumentar velocidade

% Calcular as distâncias entre os vetores coluna da matriz X
for k=1:(n-1)     % O produto vai até o nº total de dados menos 1
  for i=k+1:n      % A coluna é um a mais do que a linha
      
    % A matriz dist guarda na posição (k,i) a distância do vetor X(:,k)para 
    % o vetor X(:,i)(Distância entre a k-ésima e i-ésima colunas da matriz X) 
     
    %dista(k,i)=sqrt(dot(X(:,k)-X(:,i),X(:,k)-X(:,i)));
       %        OU  
    aux=X(:,k)-X(:,i); % Auxiliar só para economizar memória temporária
    dista(k,i)=dot(aux,aux); % Distância ao quadrado que é utilizada no peso
    
    dista(i,k)= dista(k,i);
      
  end
end
dista(n,:)=(dista(:,n))';
