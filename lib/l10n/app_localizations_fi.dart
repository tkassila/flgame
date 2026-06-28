// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get player1MoveLPiece => 'Pelaaja 1: siirrä L-nappulaa';

  @override
  String get player2MoveLPiece => 'Pelaaja 2: siirrä L-nappulaa';

  @override
  String get noFreePositionsLPiece =>
      'L-nappulalle ei ole vapaita paikkoja. Olet hävinnyt pelin!';

  @override
  String get player1MovedLPiece => 'Pelaaja 1 on siirtänyt L-nappulaa.';

  @override
  String get player2MovedLPiece => 'Pelaaja 2 on siirtänyt L-nappulaa.';

  @override
  String get movedNeutral1Piece =>
      'Pelaaja on siirtänyt neutraalia nappulaa 1.';

  @override
  String get movedNeutral2Piece =>
      'Pelaaja on siirtänyt neutraalia nappulaa 2.';

  @override
  String get movedNeutralFrame => 'Pelaaja on siirtänyt neutraalia kehystä.';

  @override
  String get movedLPieceFrame => 'Pelaaja on siirtänyt L-kehystä.';

  @override
  String get lPositionIsOld => 'L-asento on vanha! Siirrä eri asentoon.';

  @override
  String get lPositionSame =>
      'L-asento ja siirto ovat samat! Siirrä eri asentoon.';

  @override
  String get allLPositionsNotFree => 'Kaikki L-asennot on varattu!';

  @override
  String get moveOneNeutralPiece => 'Siirrä yksi neutraali nappula, kiitos';

  @override
  String get neutralPiecePositionNotFree =>
      'Tämä neutraalin nappulan paikka ei ole vapaa!';

  @override
  String get moveOneMoreNeutralPiece =>
      'Siirrä vielä yksi neutraali nappula, kiitos';

  @override
  String rowColumnLabel(int row, int col) {
    return 'Rivi: $row sarake: $col';
  }

  @override
  String get free => 'Vapaa';

  @override
  String get bottomFree => 'pohja: Vapaa';

  @override
  String bottomValue(String value) {
    return 'pohja: $value';
  }

  @override
  String get startGame => 'Aloita peli';

  @override
  String get moveDone => 'Siirto valmis';

  @override
  String get up => 'Ylös';

  @override
  String get down => 'Alas';

  @override
  String get left => 'Vasen';

  @override
  String get right => 'Oikea';

  @override
  String get wrap => 'Kierto';

  @override
  String get turn90 => 'Käännä 90º';

  @override
  String get help => 'Ohje';

  @override
  String get selectUnfinishedGames => 'Valitse keskeneräiset pelit';

  @override
  String get editPlayerNames => 'Muokkaa pelaajien nimiä';

  @override
  String get finishedGames => 'Päättyneet pelit';

  @override
  String get exitGame => 'Lopeta peli';

  @override
  String get aboutGame => 'Tietoa pelistä';

  @override
  String get selectLanguage => 'Valitse kieli';

  @override
  String get player1 => 'Pelaaja 1';

  @override
  String get player2 => 'Pelaaja 2';

  @override
  String get saveNames => 'Tallenna nimet';

  @override
  String get noSave => 'Älä tallenna';

  @override
  String get newLGame => 'Uusi L-peli';

  @override
  String get cancel => 'Peruuta';

  @override
  String get continue_ => 'Jatka';

  @override
  String get startNewGameQuery => 'Haluatko aloittaa uuden L-pelin?';

  @override
  String get newGameCreated => 'Uusi peli luotu...';

  @override
  String selectNeutral(int num) {
    return 'Valitse neutraali $num';
  }

  @override
  String playerTurnLabel(String player) {
    return 'Vuoro: $player';
  }

  @override
  String get aboutLGame => 'Tietoa L-pelistä';

  @override
  String get back => 'Takaisin';

  @override
  String get lGameTitle => 'L-peli';

  @override
  String get copyright => 'tekijänoikeus Tuomas Kassila';

  @override
  String version(String version) {
    return 'versio $version';
  }

  @override
  String get unfinishedGames => 'Keskeneräiset pelit';

  @override
  String get finishedGamesTitle => 'Päättyneet pelit';

  @override
  String get selectGame => 'Valitse peli';

  @override
  String get deleteOldGame => 'Poista vanha peli';

  @override
  String get deleteOldGameQuery => 'Haluatko poistaa vanhan L-pelin?';

  @override
  String player1Label(String name) {
    return 'Pelaaja 1: $name';
  }

  @override
  String player2Label(String name) {
    return 'Pelaaja 2: $name';
  }

  @override
  String get tapToDelete => 'Poista tämä pelisessio napauttamalla roskakoria';

  @override
  String get backIntoLGame => 'Takaisin L-peliin';

  @override
  String get scrollHelp =>
      'Vieritä ohjetekstiä ylös ja alas. Tai tarvittaessa ylhäältä alas.';

  @override
  String get swipeHelp =>
      'Pyyhkäise vasemmalta oikealle ja takaisin ohjesivujen välillä. Tai tarvittaessa ylhäältä alas.';

  @override
  String get startPositionLGame => 'L-pelin aloitusasento';

  @override
  String get allPossibleFinalPositions =>
      'Kaikki mahdolliset loppuasennot, Sininen on voittanut';

  @override
  String get losePositionsDescription =>
      'Kaikki asennot, Punaisen vuoro, joissa Punainen häviää täydelliselle Siniselle, ja Punaisella on suurin määrä siirtoja jäljellä. Katsomalla yhden siirron eteenpäin ja varmistamalla, ettei koskaan päädy mihinkään yllä olevista asennoista, voi välttää häviämisen.';

  @override
  String get finishedGameSemantics => 'Päättynyt peli';

  @override
  String get unfinishedGameSemantics => 'Keskeneräinen peli';

  @override
  String get finishedGameNameSemantics => 'Päättyneen pelin nimi';

  @override
  String get unfinishedGameNameSemantics => 'Keskeneräisen pelin nimi';

  @override
  String get loading => 'L-peli latautuu...';

  @override
  String get finishedGamesHint => 'Lista päättyneistä peleistä';

  @override
  String get unfinishedGamesHint => 'Lista keskeneräisistä peleistä';

  @override
  String get finishedGameNameHint => 'Päättyneen pelin nimi';

  @override
  String get unfinishedGameNameHint => 'Keskeneräisen pelin nimi';

  @override
  String get backButtonHint => 'Takaisin-painike';

  @override
  String get selectGameButtonHint => 'Valitse peli -painike';

  @override
  String get deleteGameButtonHint => 'Poista vanha peli';

  @override
  String get startGameButtonHint => 'Aloita peli -painike';

  @override
  String get startGameTooltip => 'Aloita uusi L-peli päättyneen pelin jälkeen.';

  @override
  String get upButtonHint => 'Ylös-painike';

  @override
  String get upTooltip => 'Siirrä L-nappulan kehystä ylöspäin.';

  @override
  String get downButtonHint => 'Alas-painike';

  @override
  String get downTooltip => 'Siirrä L-nappulan kehystä alaspäin.';

  @override
  String get leftButtonHint => 'Vasen-painike';

  @override
  String get leftTooltip => 'Siirrä L-nappulan kehystä vasemmalle.';

  @override
  String get rightButtonHint => 'Oikea-painike';

  @override
  String get rightTooltip => 'Siirrä L-nappulan kehystä oikealle.';

  @override
  String get wrapButtonHint => 'Kierto-painike';

  @override
  String get wrapTooltip => 'Kierrä L-nappulan kehystä pelilaudalla.';

  @override
  String neutralButtonHint(String neutral) {
    return '$neutral-painike';
  }

  @override
  String get neutralTooltip =>
      'Vaihda siirtokehys toiseen neutraaliin pelinappulaan.';

  @override
  String get turn90ButtonHint => 'Käännä 90º -painike';

  @override
  String get turn90Tooltip =>
      'Käännä L-kehystä 90º laudalla ja valmistaudu seuraavaan siirtoon.';

  @override
  String get helpButtonHint => 'Ohje-painike';

  @override
  String get helpTooltip => 'Tämän L-pelin ohjesivut.';

  @override
  String get moveDoneButtonHint => 'Siirto valmis -painike';

  @override
  String get moveDoneTooltip =>
      'Kun siirtokehys on paikallaan seuraavaa nappulan siirtoa varten.';

  @override
  String get moveDoneScreenReaderTooltip =>
      'Siirtokehys on oikeassa asennossa; siirrä L-nappula tai neutraali nappula tähän kohtaan.';

  @override
  String get messageLabel => 'Viesti';

  @override
  String get messageLabelHint => 'Viestikenttä';

  @override
  String get messageTooltip => 'Tämän pelin viestit.';

  @override
  String get saveNamesButtonHint => 'Tallenna nimet -painike';

  @override
  String get saveNamesTooltip =>
      'Muuta ja tallenna tämän pelin pelaajien nimet.';

  @override
  String get noSaveButtonHint => 'Älä tallenna -painike';

  @override
  String get noSaveTooltip => 'Älä tallenna tämän pelin pelaajien nimiä.';

  @override
  String get playerNameTooltip => 'Tämän pelisession pelaajan nimi.';

  @override
  String get player1TextFieldHint => 'Pelaajan 1 tekstikenttä';

  @override
  String get player2TextFieldHint => 'Pelaajan 2 tekstikenttä';

  @override
  String get saveGameDataLabel => 'Tallenna pelitiedot';

  @override
  String get saveGameDataHint =>
      'Tallenna pelitiedot tätä verkkosessiota varten';

  @override
  String get saveGameDataTooltip =>
      'Tallenna pelitiedot tätä verkkosessiota varten.';

  @override
  String get remoteGameLabel => 'Etäpeli';

  @override
  String get remoteGameHint => 'Etäpeli';

  @override
  String get remoteGameTooltip => 'Etäpeli';

  @override
  String get cancelButtonHint => 'Peruuta-painike';

  @override
  String get continueButtonHint => 'Jatka-painike';

  @override
  String get helpContent1 =>
      '<div class=\"text\"><h2>L-peli - tabletti- ja puhelinpeli</h2><p>Voit käyttää päävalikkoa valitaksesi seuraavat vaihtoehdot pelissä:</p><p>Tämä peli voi tallentaa päättyneitä/keskeneräisiä pelisessioita nykyisellä pelitilanteella. Valitse kyseinen vaihtoehto nähdäksesi luettelon tallennetuista sessioista ja pelilaudoista. Voit myös poistaa vanhoja pelisessioita painamalla rivillä olevaa roskakorin kuvaa. Voit valita keskeneräisen pelin jatkaaksesi peliä siitä, mihin pelaajat jäivät.</p><h3>Uuden L-pelin aloittamisen jälkeen</h3><p>2 pelaajalla on kummallakin yksi L-nappula. L-nappulan siirtämisen jälkeen pelaaja voi siirtää yhtä neutraaleista nappuloista. Siirron tavoite näytetään mustalla siirtokehyksellä nykyisen L-nappulan ympärillä. Valitun neutraalin nappulan ympärillä siirtokehys on joko sininen tai punainen pelaajan 1 tai 2 mukaan.</p><p>Siirtokehystä siirretään pelipöydällä painamalla keltaisia siirtonäppäimiä. Kun siirtokehys on oikeassa paikassa L-siirtoa varten, paina Siirto valmis -painiketta. Jos siirto on hyväksytty, nappula siirretään valittuun paikkaan. Tämän jälkeen siirtokehys siirtyy neutraalin nappulan ympärille. Voit vaihtaa valittua neutraalia nappulaa, jos haluat. Kun Siirto valmis -painiketta on painettu 2 kertaa, pelivuoro vaihtuu vastustajalle ja siirtokehys on hänen L-nappulansa ympärillä.</p><p>Kun Androidin TalkBack-sovellus ei ole käynnissä, voit siirtää kehystä pelilaudalla myös sormieleillä keltaisten siirtonäppäinten sijaan:</p><p><b>Pyyhkäisy ylös tai alas</b> = kehys liikkuu ylös tai alas.</b><p><b>Pyyhkäisy vasemalle tai oikealle</b> = kehys liikkuu vasemmalle tai oikealle.</p><p><b>2 napautusta pelilaudalla</b> = kehys liikkuu kuin painettaessa \'kierto\'-painiketta.</p><p><b>Pitkä painallus pelilaudalla</b> = kehys liikkuu kuin painettaessa \'käännä 90º\' -painiketta.</p><p>Pelaajan 1 L-nappula on merkitty valkoisella numerolla 1 ja se on punainen. Pelaajan 2 L-nappula on merkitty valkoisella numerolla 2 ja se on sininen. 2 neutraalia nappulaa ovat mustia. Vuorossa olevan pelaajan L-siirron musta kehys on merkitty mustalla numerolla 1 tai 2. Kun L-siirto hyväksytään, L-siirtokehys katoaa. Neutraali siirtokehys luodaan yhden neutraalin painikkeen ympärille. Kun koko siirto on valmis (toinen valmis-painikkeen painallus), L-siirtokehys siirtyy seuraavan vuorossa olevan pelaajan L-nappulan ympärille. Tässä pelin versiossa pelilaudalle on lisätty erilaisia sormieleitä, jotka vastaavat painettuja siirtonäppäimiä: pyyhkäisy vasemmalle vastaa vasenta painiketta, pyyhkäisy oikealle oikeaa painiketta, pyyhkäisy ylös yläpainiketta, pyyhkäisy alas alapainiketta, pitkä painallus 90º kääntöä ja kaksoisnapautus kiertoa.</p><h2>Wikipediasta</h2><p>Wikipediasta, vapaasta tietosanakirjasta. L-pelin lauta ja aloitusasetelma, jossa neutraalit nappulat näkyvät mustina kiekkoina:</p></div>';

  @override
  String get helpContent2 =>
      '<div><p>L-peli on yksinkertainen abstrakti strategiapeli, jonka on keksinyt Edward de Bono. Se esiteltiin hänen kirjassaan The Five-Day Course in Thinking (1967).</p><h3>Kuvaus</h3><p>L-peli on kahden pelaajan peli, jota pelataan 4×4-ruutuisella laudalla. Kummallakin pelaajalla on 3×2-ruudun kokoinen L-muotoinen nappula (tetromino), ja laudalla on kaksi 1×1-kokoista neutraalia nappulaa.</p><h3>Säännöt</h3><p>Jokaisella vuorolla pelaajan on ensin siirrettävä L-nappulansa, ja sen jälkeen hän voi valinnaisesti siirtää toista neutraaleista nappuloista. Peli voitetaan saattamalla vastustaja tilanteeseen, jossa hän ei pysty siirtämään L-nappulaansa uuteen paikkaan.</p></div>';

  @override
  String get helpContent3 =>
      '<div class=\"text\"><p>Nappulat eivät saa olla päällekkäin tai peittää muita nappuloita, eivätkä ne saa mennä laudan ulkopuolelle. L-nappulaa siirrettäessä se nostetaan ja asetetaan tyhjiin ruutuihin mihin tahansa laudalla. Sitä voidaan kääntää tai jopa kääntää ylösalaisin; ainoa sääntö on, että sen on päädyttävä eri asentoon kuin missä se oli – peittäen näin vähintään yhden ruudun, jota se ei aiemmin peittänyt. Neutraalin nappulan siirtämiseksi pelaaja yksinkertaisesti nostaa sen ja asettaa sen tyhjään ruutuun mihin tahansa laudalla.</p><h1>Strategia</h1><p>Yksi perusstrategia on käyttää neutraalia nappulaa ja omaa nappulaa 3×3-neliön estämiseen yhdessä kulmassa ja käyttää neutraalia nappulaa estämään vastustajan L-nappulan siirtyminen peilikuvamaiseen asentoon. Toinen perusstrategia on siirtää L-nappula estämään puolet laudasta ja käyttää neutraaleja nappuloita estämään vastustajan mahdolliset vaihtoehtoiset asennot.</p><p>Nämä asennot voidaan usein saavuttaa, kun neutraali nappula jätetään yhteen kahdeksasta tappajapaikasta laudan reunalla. Tappajapaikat ovat reunan ruutuja, jotka eivät ole kulmissa. Seuraavalla siirrolla aiemmin asetettu tappaja joko tehdään osaksi omaa neliötä tai sitä käytetään estämään reunapaikka, ja muodostetaan neliö- tai puoli-lautablock omalla L:llä ja siirretyllä neutraalilla nappulalla.</p><h1>Analyysi</h1><p>Kaikki asennot, Punaisen vuoro, joissa Punainen häviää täydelliselle Siniselle, ja suurin määrä siirtoja jäljellä Punaiselle. Katsomalla yhden siirron eteenpäin ja varmistamalla, ettei koskaan päädy mihinkään yllä olevista asennoista, voi välttää häviämisen. Kaikki mahdolliset loppuasennot, Sininen on voittanut</p></div>';

  @override
  String get helpContent4 =>
      '<div class=\"text\"><p>Pelissä, jossa on kaksi täydellistä pelaajaa, kumpikaan ei koskaan voita tai häviä. L-peli on tarpeeksi pieni ollakseen täysin ratkaistavissa. On olemassa 2296 erilaista mahdollista pätevää tapaa, joilla nappulat voivat olla, laskematta asennon kääntämistä tai peilaamista uudeksi asennoksi ja pitäen kahta neutraalia nappulaa identtisinä. Mikä tahansa asento voidaan saavuttaa pelin aikana, riippumatta siitä kenen vuoro on. Kumpikin pelaaja on hävinnyt 15:ssä näistä asennoista, jos on kyseisen pelaajan vuoro. Häviöasennoissa häviävän pelaajan L-nappula koskettaa kulmaa. Kumpikin pelaaja häviää pian täydelliselle pelaajalle myös 14 muussa asennossa. Pelaaja pystyy vähintään pakottamaan tasapelin (pelaamalla loputtomiin häviämättä) lopuista 2267 asennosta.</p><p>Vaikka kumpikaan pelaaja ei pelaisi täydellisesti, puolustuspeli voi jatkua loputtomiin, jos pelaajat ovat liian varovaisia siirtääkseen neutraalia nappulaa tappajapaikkoihin. Jos molemmat pelaajat ovat tällä tasolla, sääntöjen sudden death -variantti sallii molempien neutraalien nappuloiden siirtämisen siirron jälkeen. Pelaaja, joka pystyy katsomaan kolme siirtoa eteenpäin, voi voittaa puolustuspelin käyttämällä vakiosääntöjä.[selvennystä tarvitaan]</p><h1>Viitteet</h1><p>\"Games and Puzzles 1974-11: Iss 30\". A H C Publications. Marraskuu 1974.</p><h1>Muut lähteet</h1><p>de Bono, Edward (1967). \"The L Game: Strategic Thinking\". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.<p>Parlett, David (1999). \"The L-Game\". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.<p>Pritchard, D. B. (1982). \"The L Game\". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.</p><h1>Ulkoiset linkit</h1><p>L-peli Edward de Bonon virallisella sivustolla (arkistoitu)<p>Interaktiivinen verkkopohjainen L-peli kirjoitettu JavaScriptillä</p><h1>Luokat:</h1><p>Vuonna 1968 esitellyt lautapelit Abstraktit strategiapelit Matemaattiset pelit Ratkaistut pelit</p></div>';
}
