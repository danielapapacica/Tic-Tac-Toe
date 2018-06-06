function [] = afis_joc(m)

	v = '';
	
	% Afisarea tablei de X si 0
	for i=1:3
		for j=1:3
			if(m(i,j) == 0)
				v = [v '_' '|'];
			else if(m(i,j) == 1)
				v = [v 'X' '|'];
			else if(m(i,j) == 2)
				v = [v '0' '|'];
			endif
			endif
			endif
		endfor

		v(length(v)) = '';
		disp(v);
		v = '';
	endfor
	disp("\n");

endfunction
