function izhod = naloga4(vhod, Fs)
	freq_res = Fs/length(vhod);
	freq = fft(vhod);
	str = abs(freq).^2/length(vhod);
	found_tones = [];
	for k = 1:length(str)/2
		if str(k) > 30
			found_tones = [found_tones; k*freq_res];
		end
	end
	
	tones_freq = [261.6, 277.18, 293.66, 311.13, 329.63, 349.23, 369.99, 392, 415.30, 440, 466.16, 493.88];
	tones_names = [1 2 3 4 5 6 7 8 9 10 11 12];
	chords = [1 5 8; 1 4 8; 3 7 10; 3 6 10; 5 9 12; 5 8 12; 6 10 1; 6 9 1; 8 12 3; 8 11 3; 10 2 5; 10 1 5; 12 4 7; 12 3 7];
	chord_names = {'Cdur'; 'Cmol'; 'Ddur'; 'Dmol'; 'Edur'; 'Emol'; 'Fdur'; 'Fmol'; 'Gdur'; 'Gmol'; 'Adur'; 'Amol'; 'Hdur'; 'Hmol'};
	
	chord = [];
	for k = 1:length(found_tones)
		for l = 1:length(tones_freq)
			if abs(found_tones(k) -  tones_freq(l)) < 1.2
				chord = [chord; tones_names(l)];
			end
		end
	end
	
	if isempty(chord) || length(unique(chord)) < 3
		izhod = '';
		return;
	end
	
	dims_chords = size(chords);
	chord_index = 0;
	for k = 1:dims_chords(1)
		found = 1;
		found_tones = [];
		for l = 1:length(chord)
			if isempty(find(chords(k, :) == chord(l), 1))
				found = 0;
				break;
			else
				found_tones = [found_tones, chord(l)];
			end
		end
		if isequal(intersect(found_tones, chords(k, :)), chords(k, :))
			chord_index = k;
			break;
		end
	end
	
	if ~found
		izhod = '';
		return;
	end
	
	izhod = chord_names{chord_index};
	
end