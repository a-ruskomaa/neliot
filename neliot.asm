// roarusko / 10.12.2020

// Ohjelma odottaa silmukassa näppäimen painallusta. Mikäli
// painettu näppäin on numero 1-9, ohjelma piirtää näkyville
// alas painetun numeron määrän pieniä neliöitä. Neliöt pysyvät
// näkyvillä niin kauan kuin näppäin on painettuna alas. Näppäimen
// nostamisen jälkeen neliöt pyyhkiytyvät näkyvistä.

// Alkuperäinen ajatus oli toteuttaa ohjelma siten, että numerot piirrettäisiin
// morsen aakkosilla, mutta toteutuksen edetessä tämä alkoi vaikuttaa kohtuuttoman
// työläältä ja jäi haaveeksi.

@laskuri // laskuri, joka pitää kirjaa piirrettyjen neliöiden lukumäärästä
M=0
@paikka // muuttuja, jonne tallennetaan tieto pyyhittävästä muistipaikasta
M=0

@20514 // (vakio)muuttuja, joka määrää mihin kohtaan ensimmäinen neliö piirretään
D=A
@eka
M=D

// @xoffset // muuttuja, joka määrää seuraavan neliön vaakasiirtymän alkupisteestä
// M=0
// @yoffset // muuttuja, joka määrää seuraavan neliön pystysiirtymän alkupisteestä
// M=0


// OHJELMAN ALKUPISTE
// Nollataan tarvittavat muuttujat. Tänne palataan myös ruudun tyhjennyksen jälkeen.
(ALKU)
@xoffset // muuttuja, joka määrää ensimmäistä seuraavan neliön vaakasiirtymän
M=0
@yoffset // muuttuja, joka määrää piirrettävän neliön pystysiirtymän
M=0


// LUE NÄPPÄIMISTÖ
// Odottaa silmukassa sopivan näppäimen painamista. Mikäli painetaan numeronäppäintä,
// tallentaa tiedon painetusta numerosta muuttujaan "laskuri"
(LUE)
@KBD //luetaan muistipaikan sisältö, tallennetaa d-reg
D=M

//tutkii onko painettu nappain alle 49 (numero 1)
@48
D=D-A
@LUE //hypätään "aliohjelman" alkuun jos painettu näppäin epäkelpo
D;JLE  // jos d-rek arvo on alle nolla, oli näppäimen koodi alunperin <49

//tutkii onko painettu nappain yli 57 (numero 9)
@9
D=D-A
@LUE  //hypätään "aliohjelman" alkuun jos painettu näppäin epäkelpo
D;JGT // jos d-rek arvo on yli nolla, oli näppäimen koodi alunperin >57

@9 //lisätään d-rek arvoon 9 jotta saadaan numeroa vastaava arvo laskuriin
D=D+A
@laskuri
M=D


// PIIRRÄ NELIÖT
// Aloittaa piirtorutiinin. Tähän pisteeseen palataan jokaisen piirretyn neliön
// jälkeen. Aluksi tarkistetaan onko haluttu määrä piirretty.
(PIIRRA)

@laskuri //haetaan laskurin arvo rekisteriin
D=M
@LOPPU // siirrytään odotussilmukkaan, jos laskuri on nolla
D;JLE


// PIIRRETÄÄN YKSITTÄINEN NELIÖ
(NELIO)
@eka //ladataan alkupiste
D=M
@yoffset //lisätään alkupisteeseen y offset
D=D+M
@xoffset //lisätään alkupisteeseen x offset
A=D+M
M=-1 //piirretaan 1x16px musta palkki

@512 // ladataan d-rekisteriin 512 (16 [riviä] x 32 [16-bit muistipaikkaa])
D=A
@yoffset // y-offset on 512 kun on piirretty 16px korkea neliö
D=D-M
@NELIOLOPPU //neliö on valmis jos erotus on nolla (tai alle)
D;JLE

@32 // ladataan rekisteriin yhtä riviä vastaava muistipaikkojen määrä
D=A
@yoffset // kasvatetaan y-offset yhdella rivilla
D=D+M
M=D // tallennetaan muistiin uusi offset

@NELIO // ehdoton hyppy takaisin silmukan alkuun
0;JMP


// LOPPUTOIMET YHDEN NELIÖN JÄLKEEN
// Nollataan y-offset ja siirretään x-offset 32px oikealle
(NELIOLOPPU)
@yoffset //nollataan y offset
M=0

@2 // ladataan d-rekisteriin vakio 2
D=A
@xoffset //kasvatetaan x offset 32px (2 x 16px)
D=D+M
M=D // tallennetaan muistiin uusi offset

@laskuri //vähennetään laskuria yhdellä
D=M-1 
M=D // tallennetaan muistiin laskurin uusi arvo

@PIIRRA // Hypätään takaisin neliöiden piirtorutiinin alkuun
0;JMP


// NELIÖIDEN PIIRRON JÄLKEEN KÄYNNISTYVÄ SILMUKKA
// Pitää neliöt piirrettynä niin kauan kuin (mikä tahansa) näppäin on painettuna pohjaan
(LOPPU)
@KBD // luetaan tieto painetusta näppäimestä
D=M

@TYHJENNA // hypätään tyhjennykseen jos näppäin ei painettu (d-rek nolla)
D;JEQ

@LOPPU // jatketaan odottamista silmukassa
0;JMP


// TYHJENNYSRUTIINI
// Aloittaa tyhjennyksen viimeisestä muistipaikasta jonne on piirretty. Palaa
// alkusilmukkaan odottamaan näppäinpainalluksia kun kaikki piirretyt neliöt on
// pyyhitty pois.
(TYHJENNA)

@eka // ladataan alkupiste d-rekisteriin
D=M
@512 // lisätään d-rekisteriin 16 rivin edestä muistipaikkoja
D=D+A
@xoffset // lisätään d-rekisteriin vaakasuuntainen siirtymä
D=D+M
@paikka // tallennetaan tyhjennyksen alkupiste muuttujaan
M=D

// TYHJENTÄÄ YHDEN NÄYTÖN MUISTIPAIKAN
(TYHJPAIKKA)
@eka // haetaan ensimmäistä piirrettävää muistipaikkaa vastaava arvo rekisteriin
D=M
@paikka // verrataan viimeisintä tyhjennettyä paikkaa alkupisteeseen
D=D-M
@ALKU //hypätään takaisin alkusilmukkaan jos kaikki neliöt on pyyhitty
D;JGE

@paikka //vahennetaan paikka-muuttujaa yhdellä
D=M-1
M=D // tallennetaan muistiin

A=D
M=0 // pyyhitään paikka-muuttujaan tallennetusta muistipaikasta data
@TYHJPAIKKA
0;JMP