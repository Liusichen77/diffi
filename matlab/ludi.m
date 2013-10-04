function [diffi, W, epis]=ludi(X,T)
%diffi=ludi(X,T)
%[diffi, autoval, autovet]=ludi(X,T)
% % Se eu usar Autovalor e Autovetor dentro de ludi e n�o em textletras eu
% usarei o W novo, ou sj, o W associado ao antigo X vezes a matriz dos
% graus D, ou sj, o novo W � lupeso(XD) e n�o lupeso(X).

%%[diffi,d]=ludi(X,T)
% Qdo n�o quiser que apare�a diffi � s� tirar de antes do igual acima
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  DIFF MAPS                                            Data: 02/11/12   % 
%                                                                        % 
% Aluna: L�cia Maria dos Santos Pinto                                    % 
% Atualiza��es: 06/08/13                                                 % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nome do Programa:    ludi.m                                       % 
%                                                                        %   
% Objetivo: Criar uma function que dado X e T calcule a matriz finew e
% plote os autovalores.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        CHAMO UMA FUN��O PARA ACHAR O PESO W      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %W=lupeso(X); % Esta f� lupeso trabalha com as colunas da matriz dada SEM normalizar
 [W,epis]=lupeso(X); % Esta f� lupeso trabalha com as colunas da matriz dada SEM normalizar
 % %W=lupesonor(X); % Esta f� lupesonor trabalha com as colunas NORMALIZADAS 
%                  % da matriz dada, �s vezes d� problema de dimens�o 
 n=size(W,1);% N� de n�s do grafo
% Se eu usar Autovalor e Autovetor dentro de ludi e n�o em textletras eu
% usarei o W novo, ou sj, o W associado ao antigo X vezes a matriz dos
% graus D, ou sj, o novo W � lupeso(XD) e n�o lupeso(X).
 %[Autovetor, Autovalor]=eig(W); % S�o usados na extens�o de Nystr�m em textletras

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %     C�LCULO DO PESO W QUANDO OS PONTOS EST�O PR�XIMOS E ZERO C.C.     
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % n=size(X,2); % n � o n� de dados, tem que ver se � linha ou coluna de X
% % % Calcular as dist�ncias entre os vetores linha da matriz X
% % for k=1:(n-1)     % O produto vai at� o n� total de dados menos 1
% %   for i=k+1:n
% %     % A matriz dist guarda na posi��o (k,i) a dist�ncia do vetor X(k,:)para 
% %     % o vetor X(i,:)(Dist�ncia entre a k-�sima e i-�sima linhas da matriz X) 
% %       dista(k,i)=dot(X(:,k)-X(:,i),X(:,k)-X(:,i));
% %   end
% % end
% % 
% % 
% % % Criar a matriz dos pesos W
% % for k=1:(n-1) %  O produto vai at� o n� total de dados menos 1
% %   for i=k+1:n
% %     %W(i,i)=0; % N�o queremos aresta em forma de la�o
% %     %if dista(k,i)>1.4651 % Este valor estica a superf�cie S j� para T=1
% %     if dista(k,i)>1.575   % Se a dist�ncia � grande o peso da aresta � zero
% %       W(k,i)=0;
% %       W(i,k)=0;
% %    % else W(k,i)=exp((-dista(k,i))/size(X,2));% Considerei o denominador n� colunas de X
% %  else W(k,i)=exp((-dista(k,i))/size(X,1));% Considerei o denominador  n� linhas de X
% % 
% %       W(i,k)=W(k,i);
% %     end
% %   end 
% % end
% % 
% % % Os elementos da diagonal de W devem ser 1 j� que a dist�ncia de X_i para
% % % ele msm � zero.
% % for i=1:n
% %     W(i,i)=1;
% % end

            % % %S� para testar a norma de cada coluna de X se for preciso
            % % for j=1:n
            % % norma(:,j)=norm(X(:,j));
            % % end
            % % norma          
                        
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
Wnorma=D\W; % No help estas duas linhas s�o equivalentes

% d=norm(Wnorma1 - Wnorma2); % Testando se as contas acima s�o equivalentes
% return

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

% Ver se o comando diag economiza o FOR abaixo 06/08/13
diagB=diag(B); % diagB � um vetor em p� com os elementos da diagonal de B

%Para criar um vetor com os autovalores da diagonal de B
% diagB=zeros(1,n);
% for i=1:n
%     diagB(i)=B(i,i); % O vetor diagB guarda os autovalores de Wnorma
% end

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

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % TENTANDO RESOLVER O PROBLEMA DOS AUTOVALORES NEGATIVOS E GRANDES
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Conferi com peq valores e parece que est� certo isto aqui
% abs_val=abs(autoval);
% [newautoval,newind]=sort(abs_val,'descend');
% newautovet= zeros(n);             % S� pr�-aloca��o para aumentar velocidade
% for j=1:n
%     newautovet(:,j)=autovet(:,newind(j));
% end
% % S� para conferir os autovalores
%size(newautoval)
%newautoval(1,1:4)
%newautoval(1,n-4:n)
%autoval(1,1:4)
%autoval(1,n-4:n)
%size(autoval)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            DIFF MAPS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% C�lculo da fun��o diff maps 
%diffi = zeros(n);     % S� pr�-aloca��o para aumentar velocidade, mas fica 
                      % a �ltima coluna toda de zeros
%for t=0:T % Troquei 1 por 0 em 14/12/12 e troquei diffi(i,j, t) por diffi(i,j,t+1)
%for t=1:T 
    for j=1:n-1
        for i=1:n
            %O vetor diffi(i,:) � a imagem do i-�simo  n� do grafo pela diff maps, ou
            %seja, cada i-�sima linha de diffi representa a imagem do i-�simo dado do
            %problema, ou seja, a imagem da i-�sima coluna da matriz dos
            %dados que nem foi usada nesta function, mas que foi
            %considerada na function lupeso(X) que calcula W que � usada
            %aqui.
            %diffi(i,j,t)= autoval(indice(j+1))^t*autovet(i,j+1); % Coloquei este +1 para tirar o maior autovalor que � 1 e portanto n�o tende a zero com o aumento do t
            diffi(i,j,T)= autoval(indice(j+1))^T*autovet(i,j+1); % Coloquei este +1 para tirar o maior autovalor que � 1 e portanto n�o tende a zero com o aumento do t
            
            % Estou usando este NEWIND (mas n�o NEWAUTOVAL!) para pegar os
            % maiores autovalores que correspondem aos positivos maiores em
            % valor absoluto, mas na conta de diffi quero pegar o autovalor 
            % com sinal
            %diffi(i,j,t+1)= autoval(newind(j+1))^t*newautovet(i,j+1); % Coloquei este +1 no t do diffi p come�ar do zero
            
            %finew(i,j)=diffi(i,j,t); % Para usar no kmeans 
         end
    end
%end

% % %%%????????????????????????????????????????????????????????????
% % %%%%%%%%%%%%%Tentativa desesperada em 27/06/2013
% % %%%%%%%%%%%%%%%%%%%%???????????????????????????????
% % for t=1:T % d n�o se alterou com o t
% % d(:,:,t)=diffi(:,:,t)*epis;
% % end
% % size(d)
% % H=plot3(d(1:6,1,1),d(1:6,2,1),d(1:6,3,1),'o',d(7:12,1,1),d(7:12,2,1),d(7:12,3,1),'>');%,...
% % %%%%%%%%%%%%%Tentativa desesperada em 27/06/2013
% % %%%%%%%%%%%%%%%%%%%%???????????????????????????????
% % %%%%%%%%%%%????????????????????????????


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                            GR�FICO AUTOVALORES
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for j=1:n  
%     title('Queda dos autovalores')
%     H3= plot(j,autoval(j,1),'r.');
%     set(H3,'markersize',25);  hold on; grid on;   xlabel x;  ylabel Y
% end
% Para sabe o tamanho da matriz de autovalores j� que estou querendo
% aplicar ludi 2 vezes em ludiplote 23/nov/12
%tamautoval=size(autoval)