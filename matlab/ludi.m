function [diffi, W, epis]=ludi(X,T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  DIFF MAPS                                            Data: 02/11/12   % 
%                                                                        % 
% Aluna: L�cia Maria dos Santos Pinto                                    % 
% Atualiza��es: 06/08/13                                                 % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nome do Programa:    ludi.m                                            % 
%                                                                        %   
% Objetivo: Criar uma function que dado X e T calcule a matriz finew e
% plote os autovalores.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CHAMO UMA FUN��O PARA ACHAR O PESO W      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[W,epis]=lupeso(X); % Esta f� lupeso trabalha com as colunas da matriz dada SEM normalizar
n=size(W,1);% N� de n�s do grafo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        GRAUS E GRAUS RELATIVOS        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chamo a function lugrau para calcular a matriz Degree
D= lugrau(W);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        MARKOV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcular o produto D^(-1)*W (Matriz de pesos normalizada)
% e seus autovalores e autovetores
%Wnorma=inv(D)*W;
Wnorma=D\W;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       ARRUMANDO O ESPECTRO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A,B]= eig(Wnorma);

%[A,B]= eig(W,D); % Francisco sugeriu esta mudan�a para n�o dar erro no
%inv, mas os resultados ficaram  piores em ludiffcor e ludiffcor2, as 
% figuras ficaram misturadas  

%  A % matriz dos autovetores de Wnorma = inv(D)*W;
%  B % matriz cuja diagonal s�o os autovalores de Wnorma = inv(D)*W;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quero que todos os autovetores tenham a primeira componente positiva
% para ver se qdo eu vario de 0.1 at� 1.6 a letra I rodada as imagens ficam
% todas no msm lugar. 06/08/13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
for j=1:n   % n � o n� de n�s do grafo
if A(1,j)<0
    A(:,j)=-A(:,j); % Se o primeiro n� da coluna for neg ent�o troca o sinal da coluna toda 
end
end

diagB=diag(B); % diagB � um vetor em p� com os elementos da diagonal de B

% PARA ORDENAR OS AUTOVALORES DE Wnorma
[autoval,indice] = sort(diagB,'descend');
%  autoval  % vetor com autovalores de Wnorma ordenados
%  indice   % vetor com os �ndices do autovalor na matriz antes de ser

% Este FOR � para criar as colunas de uma matriz com autovetores de 
% Wnorma ordenados de forma decrescente de acordo com os correspondentes
% autovalores.
autovet= zeros(n);             % S� pr�-aloca��o para aumentar velocidade
for j=1:n
    autovet(:,j)=A(:,indice(j));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            DIFF MAPS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% C�lculo da fun��o diff maps 
    for j=1:n-1
        for i=1:n
            %O vetor diffi(i,:) � a imagem do i-�simo  n� do grafo pela diff maps, ou
            %seja, cada i-�sima linha de diffi representa a imagem do i-�simo dado do
            %problema, ou seja, a imagem da i-�sima coluna da matriz dos
            %dados que nem foi usada nesta function, mas que foi
            %considerada na function lupeso(X) que calcula W que � usada
            %aqui.
            diffi(i,j,T)= autoval(indice(j+1))^T*autovet(i,j+1); % Coloquei este +1 para tirar o maior autovalor que � 1 e portanto n�o tende a zero com o aumento do t
         end
    end
%end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                            GR�FICO AUTOVALORES
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for j=1:n  
%     title('Queda dos autovalores')
%     H3= plot(j,autoval(j,1),'r.');
%     set(H3,'markersize',25);  hold on; grid on;   xlabel x;  ylabel Y
% end
