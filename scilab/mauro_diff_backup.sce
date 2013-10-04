// Programa para calcular difusion maps



clear;  // Limpa memória

stacksize('max');
exec('/usr/share/scilab//contrib/sip-0.10.0-git/loader.sce'); // carregando o SIP

//********************************************************************************************
//  Criando a matriz de similaridade
//********************************************************************************************

path_image = 'grupo1';
current_Dir = pwd();


chdir(path_image);
//********************************************************************************************

//_______________________________________________________________
// Carregando Imagens
//_______________________________________________________________


label = ls ( '*.png' ); 			// Carrega o rotulo de todas as imagens no diretório 
n_imagens = size(label,1); 			// número de imagens


// númerando as figuras de acordo com a ordem temporal (só funciona para as figuras que estou usando)
vetor_aux = []
for i = 1 : n_imagens
	
	vetor_aux = [vetor_aux, eval( part( label(i),[8:length(label(i))-4] ) )];
	
end

clear eval;

[ new_vet, ordem ] = gsort( vetor_aux, 'c', 'i'); 			// Ordena o rotulo em ordem crescente
label = label(ordem);										// label ordenado em ordem cronologica

clear new_vet;
clear vetor_aux;
clear ordem;

//***********************************************************************************************

//_______________________________________________________________
// Criando a matriz de adjacencia do grafo formado pelos dados
//  O peso é dado pela exponencial de menos distância euclidiana de uma Imagem a outra dividido por epsilon
//_______________________________________________________________

// Matriz_dist --> seus elementos são a distância norm( IM(i)-IM(j) )
for i = 1 : n_imagens 

	image_i = gray_imread(label(i));
	image_i = image_i(:);
	
	for j = i + 1 : n_imagens
		
		image_j = gray_imread(label(j));
		
		
		Matriz_dist(i,j) = norm(image_i - image_j(:));
		Matriz_dist(j,i) = norm(image_i - image_j(:));
	end

end 


epsilon = max(Matriz_dist);

W = exp(-Matriz_dist/epsilon);		// Matriz de pesos

save('Matriz_all_dist.dat',Matriz_dist);

//********************************************************************************************
//  Diffusion Maps
//********************************************************************************************


//***********************************************************************************************

//_______________________________________________________________
// Criando a Matriz de Markov e calculando seus autovalores e autovetores
//_______________________________________________________________

D = sum(W,'c');						// Matriz Grau

P = diag(D.\1)*W					// Matriz de Markov

[autovetor, autovalor] = spec(P);	// decomposição espectral

[ autovalor, ordem_troca ] = gsort(diag(autovalor),'g','d');// ordenando os autovalores em ordem decrescente

autovetor = autovetor(:,ordem_troca);


//********************************************************************************************
//  Resultados do Diffusion maps
//********************************************************************************************

T = 2; //tempo  de difusão

// plotando nas novas coordenadas após o calculo da difusão

for i = 1 : n_imagens
	
	param3d(autovalor(2)^T*autovetor(i,2),autovalor(3)^T*autovetor(i,3),autovalor(4)^T*autovetor(i,4));
	
	f=get("hdl");
	f.mark_style = 4;
	f.mark_foreground = 5;
end



param3d(autovalor(2)*autovetor(:,2),autovalor(3)*autovetor(:,3),autovalor(4)*autovetor(:,4));

chdir(current_Dir);			// voltando para o diretório do arquivo
