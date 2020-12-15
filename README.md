# neliot

Harjoitustyönä toteutettu yksinkertainen assembly-ohjelma, joka piirtää HDL-kielellä rakennetun virtuaalisen tietokoneen ruudulle neliöitä.

Ohjelma kuuntelee numeronäppäinten painalluksia ja piirtää painettua numeroa vastaavan määrän neliöitä ruudulle.

nand2tetris -kurssilla rakennettu "Hack CPU" käyttää vain kahta rekisteriä, A- ja D-rekisteriä. A-rekisteriä käytetään muistiosoitteiden tallennukseen. D-rekisteri on yleiskäyttöinen datarekisteri. I/O-laitteet, kuten näyttö ja näppäimistö, ovat kuvattuna samaan 15-bit muistiavaruuteen kuin RAM. Suoritettava ohjelmakoodi on erillisessä ROM-muistissa.
