function rezultat_partida = partida()

m = zeros(3);
	% CITIRE OPTIUNE JUCATOR (X SAU 0)
	c = input('Doresti sa joci cu X sau cu 0 ?  ', "s");
	while(c != '0' && c != 'X' && c != 'x')
		c = input('Te rog sa-ti reintroduci optiunea: ', "s");
	endwhile

	if(c == 'x' || c == 'X')
		disp('X sa fie!');
		juc = 1;
		calc = 2;
		turn = 1;
	else if(c == '0');
		disp('0 sa fie!');
		turn = 0;
		juc = 2;
		calc = 1;	
	endif
	endif


	% INCEPE PARTIDA
	win = 0; j = 0; i = 0; v = [1 2 3]; nr_rand = 0;
	strateg1 = 0; strateg2 = 0; apar_strateg2 = 0;
	while(win == 0 && ~isempty(find(~m)) )		


		% RANDUL JUCATORULUI
		if(turn)

			% INTRODUCEREA ALEGERII POZITIEI
			disp('Introdu pozitia casutei pe care vrei sa joci.');
			i = input('Linie: ');
			j = input('Coloana: ');

			while(~ismember(i,v) || ~ismember(j,v) || m(i,j))
				disp('Casuta deja ocupata sau nu exista. Te rog sa reintroduci optiunea.');
				i = input('Linie: ');
				j = input('Coloana: ');
				disp("\n");
			endwhile
			m(i,j) = juc;


			% IN CAZUL IN CARE CASTIGA JUCATORUL (STIM CA NU SE VA INTAMPLA ASTA... :) )
			w = verif_castig(m, i, j, juc);
			if(w(1))				
				disp("Felicitari! Ai castigat aceasta partida ;) Data viitoare nu vei mai fi la fel de norocos!");
				win = 1;
				rezultat_partida = 2;
			endif
			
			turn = 0;


		% RANDUL CALCULATORULUI
		else
			jucat = 0;

			
			% DACA CALCULATORUL ESTE APROAPE DE A CASTIGA
			if(nr_rand > 3)
				castig = verif_castig(m, poz_ultim(1), poz_ultim(2), calc);
				if(length(castig) == 3)
					m(castig(2), castig(3)) = calc;
					win = 1;
					rezultat_partida = 1;
					disp("\tAi pierdut aceasta partida :(");
					jucat = 1;
					
				endif
				
			endif



			% DACA JUCATORUL ESTE APROAPE DE A CASTIGA (IL BLOCAM)
			if(nr_rand)			
				if(length(w) > 2 && ~jucat)
					m(w(2), w(3)) = calc;
					poz_ultim = [w(2) w(3)];
					jucat = 1;
				endif
			else
				% Alegere strategie pentru prima miscare a calculatorului
				aleg = randi(2);

				if(aleg == 1)
					m(2,2) = calc;
					poz_ultim = [2 2];
					strateg1 = 1;
				else
					x = randi(2);
					if( x == 2) x++; endif

					y = randi(2);
					if( y == 2) y++; endif

					m(x, y) = calc;
					poz_ultim = [x y];
					strateg2 = 1;
				endif

				jucat = 1;
			endif


			% APARARE CONTRA STRATEGIA 1
			if(nr_rand == 1 && i == 2 & j == 2)
				m(3,3) = calc;
				poz_ultim = [3 3];
				jucat = 1;
			endif

			% APLICAM STRATEGIA 1
			if(strateg1 && nr_rand == 2 && ~jucat)

				if(i == 2)
					m(i+1,j) = calc;
					poz_ultim = [i+1 j];
					simet = 1;
					jucat = 1;
				else if(j == 2)
					m(i, j+1) = calc;
					poz_ultim = [i j+1];
					simet = 2;
					jucat = 1;
				else
					simet = 0;
				endif endif
			endif

			% TOT PENTRU STRATEGIA 1
			if(~jucat && strateg1 && simet)
				if(simet == 1)
					m(poz_ultim(1), j) = 1;
					poz_ultim(2) = j;
				else if(simet == 2)
					m(i, poz_ultim(2)) = 1;
					poz_ultim(1) = i;
				endif
				endif
				jucat = 1;
			endif


			% APARARE CONTRA STRATEGIA 2
			if(nr_rand == 1 && mod(i,2) == 1 && mod(j,2) == 1)

				m(2, 2) = calc;
				poz_ultim = [2 2];
				jucat = 1;
				apar_strateg2 = [1 i j];
			endif

			% CONTINUARE APARARE STRATEG 2
			if(apar_strateg2(1) && nr_rand == 3 && [i j] == 4-apar_strateg2(2:3))

				m(3,2) = calc;
				poz_ultim = [3 2];
				jucat = 1;
			endif

			% APLICAM STRATEGIA 2
			if(strateg2 && nr_rand == 2 && ~jucat)

				% Cazul 1 : jucatorul pune pe o margine
				if((i == 2 || j == 2) && i != j)
					m(2,2) = calc;
					
					% daca jucatorul plaseaza 0 langa x
					if( abs(i-poz_ultim(1)) +  abs(j-poz_ultim(2)) == 1)

						%daca x este pe diagonala principala
						if(poz_ultim(1) == poz_ultim(2))
							caz = [1 1 i j];
						%daca x este pe diagonala secundara
						else
							caz = [1 2 i j];
						endif

	
					endif
					
					poz_ultim = [2 2];
					
							
					
				endif
			
				% Cazul 2: jucatorul pune in colturi pe diagonala transversala
				if(i == j && i != 2 && poz_ultim(1) + poz_ultim(2) == 4)
					m(poz_ultim(2), poz_ultim(1)) = calc;
					poz_ultim = fliplr(poz_ultim);
				else if(poz_ultim(1) == poz_ultim(2) && i+j == 4 && i != 2)
					m(4 - poz_ultim(1), 4 - poz_ultim(2)) = calc;
					poz_ultim = [ 4-poz_ultim(1) 4-poz_ultim(2) ];
			
				endif endif
				
				% Cazul 3: jucatorul pune in coltul opus
				if(i == 4-poz_ultim(1) && j == 4-poz_ultim(2))
					m(i, poz_ultim(2)) = calc;
					caz = [3 poz_ultim(1) j];
					poz_ultim = [i poz_ultim(2)];

				endif
				
				% Cazul 4: jucatorul pune in centru
				if(i == 2 && j == 2)
					m(4-poz_ultim(1), 4-poz_ultim(2)) = calc;
					caz = [4 poz_ultim(1) poz_ultim(2)];
					poz_ultim = fliplr(poz_ultim);
				endif

				jucat = 1;	
				
			endif


			% TOT STRATEGIA 2,  continuare CAZUL 1
			if(strateg2 && ~jucat && caz(1) == 1)
				% daca primul x a fost pus pe diagonala principala
				if(caz(2) == 1)
					if(caz(3) < caz(4))
						m(3,1) = calc;
						poz_ultim = [3 1];
					else
						m(1,3) = calc;
						poz_ultim = [1 3];
					endif

				% daca primul x a fost pus pe diagonala secundara	
				else
					if(caz(3) + caz(4) < 4)
						m(3,3) = calc;
						poz_ultim = [3 3];
					else
						m(1,1) = calc;
						poz_ultim = [1 1];
					endif

				endif

				jucat = 1;
			endif


			% TOT STRATEGIA 2,  continuare CAZUL 3
			if(strateg2 && ~jucat && caz(1) == 3)
				m(caz(2), caz(3)) =  calc;
				poz_ultim = [caz(2) caz(3)];
				jucat = 1;

			endif



			% PUNE RANDOM CAND NU MAI ARE POSIBILITATI
			if(~jucat)
				poz_null = find(m == 0);
				poz_rand = poz_null(randi(length(poz_null)));
				if(mod(poz_rand, 3) == 0);
					poz_ultim = [3 poz_rand/3];
				else
					poz_ultim = [mod(poz_rand,3) ceil(poz_rand/3)];
				endif
				m(poz_ultim(1), poz_ultim(2)) = calc;
			endif

			disp('Calculatorul a jucat:');
			turn = 1;
		endif
	
		afis_joc(m);
		nr_rand++;
		
	
	endwhile

	if(win == 0)
		disp("\nRemiza!\n");
		rezultat_partida = 0;
	endif


endfunction
