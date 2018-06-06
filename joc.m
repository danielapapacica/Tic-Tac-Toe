function [] = joc()

	% AFISARE REGULI PENTRU JUCATOR
	disp("\tLa fiecare partida vei avea posibilitatea de a alege sa joci cu X sau cu 0. X este intotdeauna primul care incepe.");
	disp("\t Pentru a opta pentru casuta pe care vei pune X sau 0 trebuie sa introduci numarul liniei si al coloanei corespondent casutei.\n");
	

	scor_juc = 0; scor_calc = 0; aleg = 'da';

	while(aleg == 'da' || aleg =='Da'|| aleg =='D'|| aleg =='d')
		% Joaca partida
		rezultat_partida = partida();

		% Calculeaza scor
		if(rezultat_partida == 1)
			scor_calc++;
		else if(rezultat_partida == 2)
			scor_juc++;
		endif endif

		% Afiseaza scorul
		disp("\nSCOR:");
		fprintf("\tTu:%d - Calculator:%d", scor_juc, scor_calc);
		aleg = input("\tDoresti sa continui jocul?(Da/Nu) ", "s");

		while(~(aleg == 'da') && ~(aleg == 'nu') && ~(aleg == 'Da') && ~(aleg == 'Nu') && ~(aleg == 'N') && ~(aleg == 'n') && ~(aleg == 'D') && ~(aleg == 'd'))
			aleg = input("\tTe rog sa-ti reintroduci optiunea.(Da/Nu) ", "s");
		endwhile

	endwhile

	disp("Sper ca te-ai distrat!\nSCOR FINAL:");
	fprintf("\tTu:%d - Calculator:%d\n", scor_juc, scor_calc);

endfunction
