function D = lugrau(W)
% Esta fun��o calcula a matriz grau de um grafo sabendo-se a matriz W, ou 
% seja, acha uma matriz diagonal cujos elementos n�o nulos s�o as somas das 
% linhas de W. 
% Data: 09/set/12,   Programador: L�cia 

% Descri��o das mudan�as: c�digo original. 
%
% Defini��o das vari�veis:
% n      ==> n� de v�rtices do grafo
% W      ==> matriz peso do grafo, tem que ser dada previamente
% D      ==> nome da matriz degree
% i,j,soma ==> vari�veis auxiliares
%

% Ver se sum(W) economiza este FOR
% Criar a matriz Degree D
n=size(W,1);   % n� de n�s do grafo
D=zeros(n);                 % S� prealoca��o para aumentar velocidade
for i=1:n  
    soma =0;
  for j=1:n
      D(i,i)=soma + W(i,j); % D(i,i) � a soma da linha i de W
      soma = D(i,i);
  end
end
%D


