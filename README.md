# neliot

Harjoitustyönä toteutettu yksinkertainen assembly-ohjelma, joka piirtää nand2tetris-kurssilla luodun virtuaalisen tietokoneen ruudulle neliöitä.

Ohjelma kuuntelee numeronäppäinten painalluksia ja piirtää painettua numeroa vastaavan määrän neliöitä ruudulle.

nand2tetriksen "Hack CPU" käyttää vain kahta rekisteriä, A- ja D-rekisteriä. A-rekisteriä käytetään muistiosoitteiden tallennukseen. D-rekisteri on yleiskäyttöinen datarekisteri. Suoritettava ohjelmakoodi on ROM-muistissa. RAM-muistin kautta luetaan ja kirjoitetaan myös I/O-laitteita kuten näyttöä ja näppäimistöä.
