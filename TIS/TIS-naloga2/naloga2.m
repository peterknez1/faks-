function [izhod, R, kodBela, kodCrna] = naloga2(vhod)
  % Izvedemo kodiranje vhodne binarne slike (matrike) vhod
  % po modificiranem standardu ITU-T T.4.
  % Slika vsebuje poljubno stevilo vrstic in 1728 stolpcev.
  %
  % vhod     - matrika, ki predstavlja sliko
  % izhod    - binarni vrsticni vektor
  % R        - kompresijsko razmerje
  % kodBela  - matrika dolzin zaporedij belih slikovnih tock
  %		         in dolzin kodnih zamenjav
  % kodCrna  - matrika dolzin zaporedij crnih slikovnih tock
  %		         in dolzin kodnih zamenjav

  izhod = NaN;
  R = NaN;
  kodBela = []; 
  kodCrna = [];
  verizno = [];
  veriznoStevec = 1;
  bela = [];
  crna = [];
  checker = 1;
  marker = [];
  stevecBela0 = 0;
  %disp(length(vhod(:, 1)));
  verizno = [];
  sumBelih = 0;
  sumCrnih = 0;
  %printf("%d je belih na vhod, %d je crnih\n", sumBelih, sumCrnih);
  sumbelih0 = 0;
  sumBelihVerizno = 0;
  sumCrnihVerizno = 0;
  sumvseh = 0;
  for(i=1:length(vhod(:, 1)))
    [vrstica1, marker1] = vrstica(vhod(i, :));
    %printf("%d %d\n", length(marker1), length(vrstica1));
    %disp(marker1);
    [sumBelih1, sumCrnih1, belaZnaki, crnaZnaki] = sestejPoVrstici(vrstica1);
    bela = [bela, belaZnaki];
    crna = [crna, crnaZnaki];
    sumBelihVerizno = sumBelihVerizno + sumBelih1;
    sumCrnihVerizno = sumCrnihVerizno + sumCrnih1;
    verizno = [verizno, vrstica(vhod(i, :))];
    marker = [marker, marker1];
    
  end
  
  checker = 0;
  belastevec = 1;
  crnastevec = 1;
  belachecker = 1;
  
  %printf("verizno ima vse skupaj %d, od tega %d belih in %d crnih", sumvseh, sumBelihVerizno, sumCrnihVerizno);
  uniqbela = unique(bela);
  uniqcrna = unique(crna);
  frekvencebela = histc(bela, uniqbela);
  frekvencebeladisp = [uniqbela', frekvencebela'];
  if(length(frekvencebela) > 0)
  frekvencebela = frekvencebela./length(bela);
  end
  frekvencecrna = histc(crna, uniqcrna);
  frekvencecrnadisp = [uniqcrna', frekvencecrna'];
    frekvencecrna = frekvencecrna./length(crna);
  stBelih = 0;
  %disp("frekvencebela");
  %disp(frekvencebeladisp);
  %disp("frekvencecrna");
  %disp(frekvencecrnadisp);
  stCrnih = 0;
  %printf("st belih %d, st crnih %d, skupaj %d", stBelih, stCrnih, stBelih + stCrnih);
  bela1 = [uniqbela', frekvencebela'];
  crna1 = [uniqcrna', frekvencecrna'];
  bela1 = sortrows(bela1, [2, 1]);
  crna1 = sortrows(crna1, [2, 1]);
  %disp(uniqbela);
  lbeli = [];
  lcrni = [];
  for(i=1:length(uniqbela))
    lbeli(i) = 1;
  end
  
  for(i=1:length(uniqcrna))
    lcrni(i) = 1;
  end
  ibeli = zeros(1, length(uniqbela));
  jbeli  = zeros(1, length(uniqbela));
  povezaveBela = zeros(1, length(uniqbela));
  kodneZamenjaveBela = zeros(1, length(uniqbela));
  matrikabeli = [bela1, lbeli', ibeli', jbeli', povezaveBela', kodneZamenjaveBela'];
  
  icrni = zeros(1, length(uniqcrna));
  jcrni = zeros(1, length(uniqcrna));
  povezaveCrna = zeros(1, length(uniqcrna));
  kodneZamenjaveCrna = zeros(1, length(uniqcrna));
  matrikacrni = [crna1, lcrni', icrni', jcrni', povezaveCrna', kodneZamenjaveCrna'];
  
  verjetnostBela = 0;
  dolzinaTabeleBela = length(uniqbela);
  
  verjetnostCrna = 0;
  dolzinaTabeleCrna = length(uniqcrna);
  
  while(verjetnostBela < 1)
    verjetnostBela = 0;
    [verjetnostBelaprva, indeks1] = min(matrikabeli(:, 2));
    verjetnostBela = verjetnostBela + verjetnostBelaprva;
    matrikabeli(indeks1, 2) = matrikabeli(indeks1, 2) + 1;
    [verjetnostBeladruga, indeks2] = min(matrikabeli(:, 2));
    verjetnostBela = verjetnostBela  + verjetnostBeladruga;
    matrikabeli(indeks2, 2) = matrikabeli(indeks2, 2) + 1;
    lnovevrstice = -1;
    matrikabeli(indeks1, 6) = dolzinaTabeleBela + 1;
    matrikabeli(indeks2, 6) = dolzinaTabeleBela + 1;;
    novavrstica = [-1, verjetnostBela, lnovevrstice, indeks1, indeks2, 0, 0];
    matrikabeli = [matrikabeli; novavrstica];
    dolzinaTabeleBela = dolzinaTabeleBela + 1;
  end
  
  
  while(verjetnostCrna < 1)
    verjetnostCrna = 0;
    [verjetnostCrnaprva, indeks1] = min(matrikacrni(:, 2));
    verjetnostCrna = verjetnostCrna + verjetnostCrnaprva;
    matrikacrni(indeks1, 2) = matrikacrni(indeks1, 2) + 1;
    [verjetnostCrnadruga, indeks2] = min(matrikacrni(:, 2));
    verjetnostCrna = verjetnostCrna  + verjetnostCrnadruga;
    matrikacrni(indeks2, 2) = matrikacrni(indeks2, 2) + 1;
    lnovevrstice = -1;
    matrikacrni(indeks1, 6) = dolzinaTabeleCrna + 1;
    matrikacrni(indeks2, 6) = dolzinaTabeleCrna + 1;;
    novavrstica = [-1, verjetnostCrna, lnovevrstice, indeks1, indeks2, 0, 0];
    matrikacrni = [matrikacrni; novavrstica];
    dolzinaTabeleCrna = dolzinaTabeleCrna + 1;
  end
  
  for(i = 1:length(uniqbela))
    indeks = i;
    dolzinaZnaka = 0;
    while(matrikabeli(indeks, 6) != 0)
      indeks = matrikabeli(indeks, 6);
      dolzinaZnaka++;
    end
    matrikabeli(i, 3) = dolzinaZnaka;
  end
  
  for(i = 1:length(uniqcrna))
    indeks = i;
    dolzinaZnaka = 0;
    while(matrikacrni(indeks, 6) != 0)
      indeks = matrikacrni(indeks, 6);
      dolzinaZnaka++;
    end
    matrikacrni(i, 3) = dolzinaZnaka;
  end
  %disp(matrikabeli);
  %disp("//");
  %disp(matrikacrni);
  %disp("//");
  matrikabeli = matrikabeli(1:length(uniqbela), :);
  matrikabeli = sortrows(matrikabeli, [3, 1]);
  
  kodneZamenjaveBela = zeros(1, length(uniqbela));
  stevec1 = 0;
  for(i=1:length(uniqbela))
    matrikabeli(i, 7) = stevec1;
    if(i > 1)
      shiftVrednost = matrikabeli(i, 3) - matrikabeli(i - 1, 3);
      if(shiftVrednost > 0)
        vrednost = bitshift(matrikabeli(i, 7), shiftVrednost);
        matrikabeli(i, 7) = vrednost;
        stevec1 = vrednost;
      end
    end
    stevec1 = stevec1 + 1;
  end
  
  matrikacrni = matrikacrni(1:length(uniqcrna), :);
  matrikacrni = sortrows(matrikacrni, [3, 1]);
  kodneZamenjaveCrna = zeros(1, length(uniqcrna));
  stevec2 = 0;
  for(i=1:length(uniqcrna))
    matrikacrni(i, 7) = stevec2;
    if(i > 1)
      shiftVrednost = matrikacrni(i, 3) - matrikacrni(i - 1, 3);
      if(shiftVrednost > 0)
        vrednost = bitshift(matrikacrni(i, 7), shiftVrednost);
        matrikacrni(i, 7) = vrednost;
        stevec2 = vrednost;
      end
    end
    stevec2 = stevec2 + 1;
  end
  
  vrednostiBela = zeros(1, length(uniqbela));
  for(i=1:length(uniqbela))
    vrednostiBela(i) = matrikabeli(i, 1);
  end

  dolzineBela = zeros(1, length(uniqbela));
  for(i=1:length(uniqbela))
    dolzineBela(i) = matrikabeli(i, 3);
  end
  
  vrednostiCrna = zeros(1, length(uniqcrna));
  for(i=1:length(uniqcrna))
    vrednostiCrna(i) = matrikacrni(i, 1);
  end

  dolzineCrna = zeros(1, length(uniqcrna));
  for(i=1:length(uniqcrna))
    dolzineCrna(i) = matrikacrni(i, 3);
  end
  
  kodBela = [vrednostiBela', dolzineBela'];
  kodBela = sortrows(kodBela, [2, 1]);
  
  kodCrna = [vrednostiCrna', dolzineCrna'];
  kodCrna = sortrows(kodCrna, [2, 1]);
  %disp('//');
  %disp("kodBela");
  %disp(kodBela);
  %disp("kodCrna")
  %disp(kodCrna);
  printf("%d %d\n", length(marker), length(verizno));
  izhod = [];
  for(i=1:length(verizno))
    x = verizno(i);
    if(marker(i) == 1)
      [i] = find(vrednostiBela == x);
      koda = dec2bin(matrikabeli(i, 7), matrikabeli(i, 3));
      koda = koda - "0";
      izhod = [izhod, koda];
    else
      [i] = find(vrednostiCrna == x);
      koda = dec2bin(matrikacrni(i, 7), matrikacrni(i, 3));
      koda = koda - "0";
      izhod = [izhod, koda];
    end
  end
 dolzinaVhoda = length(vhod(:, 1)) * 1728;
 R = length(izhod)/dolzinaVhoda;
 %disp("verizno");
 %disp(verizno);
 %disp("izhod");
 %disp(izhod);
disp(length(izhod));
disp(length(vhod));
  
end
function [novaVrstica, marker] = vrstica(vhod)
  marker = [];
  checker = 1;
  novaVrstica = [];
  veriznoStevec = 1;
  if(vhod(1) == 0)
    novaVrstica(1) = 0;
    marker(1) = 1;
    veriznoStevec = veriznoStevec + 1;
    novaVrstica(2) = 1;
    marker(veriznoStevec) = 0;
    checker = 0;
  else
    novaVrstica(1) = 1;
    marker(1) = 1;
  end
  for(i=2:1728)
    if(vhod(i) == checker)
      novaVrstica(veriznoStevec) = novaVrstica(veriznoStevec) + 1;
    else
      veriznoStevec = veriznoStevec + 1;
      novaVrstica(veriznoStevec) = 1;
      checker = vhod(i);
      marker(veriznoStevec) = checker;
    end
    
  end
endfunction

function [sumBelih, sumCrnih, belaZnaki, crnaZnaki] = sestejPoVrstici(vrstica)
  sumBelih = 0;
  sumCrnih = 0;
  bela = 1;
  belaZnaki = [];
  crnaZnaki = [];
  for(i=1:length(vrstica))
    if(bela == 1)
      sumBelih = sumBelih + vrstica(i);
      belaZnaki = [belaZnaki, vrstica(i)];
      bela = 0;
    else
      sumCrnih = sumCrnih + vrstica(i);
      crnaZnaki = [crnaZnaki, vrstica(i)];
      bela = 1;
    end
    
  end
endfunction
