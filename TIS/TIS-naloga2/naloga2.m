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
  if(vhod(1) == 0)
    verizno(1) = 0;
    checker = 0;
    veriznoStevec = veriznoStevec + 1;
    verizno(veriznoStevec) = 0;
  end
  for i=1:1728
    if(vhod(i) != checker)
      checker = vhod(i);
      veriznoStevec = veriznoStevec + 1;
      verizno(veriznoStevec) = 0;
    end
      verizno(veriznoStevec) = verizno(veriznoStevec) + 1;
  end
  
  
  checker = 0;
  belastevec = 1;
  crnastevec = 1;
  for(i=1:length(verizno))
    if(checker == 0)
      bela(belastevec) = verizno(i);
      belastevec = belastevec + 1;
      checker = 1;
    else
      crna(crnastevec) = verizno(i);
      crnastevec = crnastevec + 1;
      checker = 0;
      
     end
   
  end
  uniqbela = unique(bela);
  uniqcrna = unique(crna);
  frekvencebela = histc(bela, uniqbela);
  frekvencebela = frekvencebela./length(bela);
  frekvencecrna = histc(crna, uniqcrna);
  frekvencecrna = frekvencecrna./length(crna);
  bela1 = [uniqbela', frekvencebela'];
  crna1 = [uniqcrna', frekvencecrna'];
  bela1 = sortrows(bela1, [-2, 1]);
  disp(bela1);
  disp('//');
  disp(crna1);
  crna1 = sortrows(crna1, [-2, 1]);
  disp('//');
  disp(crna1);
  
  matrikabeli = []
end