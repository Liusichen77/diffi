function D = lugrau(W)
% Esta função calcula a matriz grau de um grafo sabendo-se a matriz W, ou 
% seja, acha uma matriz diagonal cujos elementos não nulos são as somas das 
% linhas de W. 
% Data: 09/set/12,   Programador: Lúcia 

% Descrição das mudanças: código original. 
%
% Definição das variáveis:
% n      ==> nº de vértices do grafo
% W      ==> matriz peso do grafo, tem que ser dada previamente
% D      ==> nome da matriz degree
% i,j,soma ==> variáveis auxiliares
%

% Ver se sum(W) economiza este FOR
% Criar a matriz Degree D
n=size(W,1);   % nº de nós do grafo
D=zeros(n);                 % Só prealocação para aumentar velocidade
for i=1:n  
    soma =0;
  for j=1:n
      D(i,i)=soma + W(i,j); % D(i,i) é a soma da linha i de W
      soma = D(i,i);
  end
end
%D


