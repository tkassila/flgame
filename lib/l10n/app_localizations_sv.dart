// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get player1MoveLPiece => 'Spelare 1: flytta L-pjäsen';

  @override
  String get player2MoveLPiece => 'Spelare 2: flytta L-pjäsen';

  @override
  String get noFreePositionsLPiece =>
      'Det finns inga lediga positioner för L-pjäsen. Du har förlorat spelet!';

  @override
  String get player1MovedLPiece => 'Spelare 1 har flyttat L-pjäsen.';

  @override
  String get player2MovedLPiece => 'Spelare 2 har flyttat L-pjäsen.';

  @override
  String get movedNeutral1Piece => 'Spelaren har flyttat neutral pjäs 1.';

  @override
  String get movedNeutral2Piece => 'Spelaren har flyttat neutral pjäs 2.';

  @override
  String get movedNeutralFrame => 'Spelaren har flyttat den neutrala ramen.';

  @override
  String get movedLPieceFrame => 'Spelaren har flyttat L-ramen.';

  @override
  String get lPositionIsOld =>
      'L-positionen är den gamla! Flytta till en annan position.';

  @override
  String get lPositionSame =>
      'L-positionen och draget är detsamma! Flytta till en annan position.';

  @override
  String get allLPositionsNotFree => 'Alla L-positioner är upptagna!';

  @override
  String get moveOneNeutralPiece => 'Flytta en neutral pjäs, tack';

  @override
  String get neutralPiecePositionNotFree =>
      'Denna neutrala pjäsposition är inte ledig!';

  @override
  String get moveOneMoreNeutralPiece =>
      'Flytta ytterligare en neutral pjäs, tack';

  @override
  String rowColumnLabel(int row, int col) {
    return 'Rad: $row kolumn: $col';
  }

  @override
  String get free => 'Ledig';

  @override
  String get bottomFree => 'botten: Ledig';

  @override
  String bottomValue(String value) {
    return 'botten: $value';
  }

  @override
  String get startGame => 'Starta spel';

  @override
  String get moveDone => 'Drag klart';

  @override
  String get up => 'Upp';

  @override
  String get down => 'Ner';

  @override
  String get left => 'Vänster';

  @override
  String get right => 'Höger';

  @override
  String get wrap => 'Wrap';

  @override
  String get turn90 => 'Vrid 90º';

  @override
  String get help => 'Hjälp';

  @override
  String get selectUnfinishedGames => 'Välj oavslutade spel';

  @override
  String get editPlayerNames => 'Redigera spelarnamn';

  @override
  String get finishedGames => 'Avslutade spel';

  @override
  String get exitGame => 'Avsluta spel';

  @override
  String get aboutGame => 'Om spelet';

  @override
  String get selectLanguage => 'Välj språk';

  @override
  String get player1 => 'Spelare 1';

  @override
  String get player2 => 'Spelare 2';

  @override
  String get saveNames => 'Spara namn';

  @override
  String get noSave => 'Spara inte';

  @override
  String get newLGame => 'Nytt L-spel';

  @override
  String get cancel => 'Avbryt';

  @override
  String get continue_ => 'Fortsätt';

  @override
  String get startNewGameQuery => 'Vill du starta ett nytt L-spel?';

  @override
  String get newGameCreated => 'Nytt spel skapat...';

  @override
  String selectNeutral(int num) {
    return 'Välj neutral $num';
  }

  @override
  String playerTurnLabel(String player) {
    return 'Tur: $player';
  }

  @override
  String get aboutLGame => 'Om LGame';

  @override
  String get back => 'Tillbaka';

  @override
  String get lGameTitle => 'L-spel';

  @override
  String get copyright => 'upphovsrätt Tuomas Kassila';

  @override
  String version(String version) {
    return 'version $version';
  }

  @override
  String get unfinishedGames => 'Oavslutade spel';

  @override
  String get finishedGamesTitle => 'Avslutade spel';

  @override
  String get selectGame => 'Välj spel';

  @override
  String get deleteOldGame => 'Ta bort gammalt spel';

  @override
  String get deleteOldGameQuery => 'Vill du ta bort ett gammalt L-spel?';

  @override
  String player1Label(String name) {
    return 'Spelare 1: $name';
  }

  @override
  String player2Label(String name) {
    return 'Spelare 2: $name';
  }

  @override
  String get tapToDelete =>
      'För att ta bort denna spelsession, tryck på papperskorgen';

  @override
  String get backIntoLGame => 'Tillbaka till LGame';

  @override
  String get scrollHelp =>
      'Scrolla upp och ner mellan hjälptexten. Eller vid behov uppifrån och ner.';

  @override
  String get swipeHelp =>
      'Svep från vänster till höger och tillbaka mellan hjälpsidorna. Eller vid behov uppifrån och ner.';

  @override
  String get startPositionLGame => 'Startposition för L-spelet';

  @override
  String get allPossibleFinalPositions =>
      'Alla möjliga slutpositioner, Blå har vunnit';

  @override
  String get losePositionsDescription =>
      'Alla positioner, Röd i tur, där Röd förlorar mot en perfekt Blå, och maximalt antal drag kvar för Röd. Genom att titta ett drag framåt och se till att man aldrig hamnar i någon av ovanstående positioner kan man undvika att förlora.';

  @override
  String get finishedGameSemantics => 'Avslutat spel';

  @override
  String get unfinishedGameSemantics => 'Oavslutat spel';

  @override
  String get finishedGameNameSemantics => 'Namn på avslutat spel';

  @override
  String get unfinishedGameNameSemantics => 'Namn på oavslutat spel';

  @override
  String get loading => 'L-spelet laddas...';

  @override
  String get finishedGamesHint => 'Lista över avslutade spel';

  @override
  String get unfinishedGamesHint => 'Lista över oavslutade spel';

  @override
  String get finishedGameNameHint => 'Namn på avslutat spel';

  @override
  String get unfinishedGameNameHint => 'Namn på oavslutat spel';

  @override
  String get backButtonHint => 'Bakåtknapp';

  @override
  String get selectGameButtonHint => 'Välj spel-knapp';

  @override
  String get deleteGameButtonHint => 'Ta bort ett gammalt spel';

  @override
  String get startGameButtonHint => 'Starta spel-knapp';

  @override
  String get startGameTooltip =>
      'Starta ett nytt L-spel efter det avslutade spelet.';

  @override
  String get upButtonHint => 'Upp-knapp';

  @override
  String get upTooltip => 'Flytta L-pjäsens ram uppåt.';

  @override
  String get downButtonHint => 'Ner-knapp';

  @override
  String get downTooltip => 'Flytta L-pjäsens ram nedåt.';

  @override
  String get leftButtonHint => 'Vänster-knapp';

  @override
  String get leftTooltip => 'Flytta L-pjäsens ram åt vänster.';

  @override
  String get rightButtonHint => 'Höger-knapp';

  @override
  String get rightTooltip => 'Flytta L-pjäsens ram åt höger.';

  @override
  String get wrapButtonHint => 'Wrap-knapp';

  @override
  String get wrapTooltip => 'Wrap L-pjäsens ram på spelbrädet.';

  @override
  String neutralButtonHint(String neutral) {
    return '$neutral-knapp';
  }

  @override
  String get neutralTooltip =>
      'Ändra dragramen till en annan neutral spelpjäs.';

  @override
  String get turn90ButtonHint => 'Vrid 90º-knapp';

  @override
  String get turn90Tooltip =>
      'Vrid L-ramen 90º på brädet och förbered för nästa drag.';

  @override
  String get helpButtonHint => 'Hjälp-knapp';

  @override
  String get helpTooltip => 'Hjälpsidor för detta L-spel.';

  @override
  String get moveDoneButtonHint => 'Drag klart-knapp';

  @override
  String get moveDoneTooltip =>
      'När dragramen är i position för nästa pjäsdrad.';

  @override
  String get moveDoneScreenReaderTooltip =>
      'Dragramen är i rätt position och flyttar en L-pjäs eller en neutral pjäs till denna position.';

  @override
  String get messageLabel => 'Meddelande';

  @override
  String get messageLabelHint => 'Meddelandeetikett';

  @override
  String get messageTooltip => 'Meddelanden i detta spel.';

  @override
  String get saveNamesButtonHint => 'Spara namn-knapp';

  @override
  String get saveNamesTooltip => 'Ändra och spara spelarnas namn i detta spel.';

  @override
  String get noSaveButtonHint => 'Spara inte-knapp';

  @override
  String get noSaveTooltip => 'Spara inte spelarnas namn i detta spel.';

  @override
  String get playerNameTooltip => 'En spelares namn i detta sessionsspel.';

  @override
  String get player1TextFieldHint => 'Textfält för Spelare 1';

  @override
  String get player2TextFieldHint => 'Textfält för Spelare 2';

  @override
  String get saveGameDataLabel => 'Spara speldata';

  @override
  String get saveGameDataHint => 'Spara speldata för denna websession';

  @override
  String get saveGameDataTooltip => 'Spara speldata för denna websession.';

  @override
  String get remoteGameLabel => 'Fjärrspel';

  @override
  String get remoteGameHint => 'Fjärrspel';

  @override
  String get remoteGameTooltip => 'Fjärrspel';

  @override
  String get cancelButtonHint => 'Avbryt-knapp';

  @override
  String get continueButtonHint => 'Fortsätt-knapp';

  @override
  String get helpContent1 =>
      '<div class=\"text\"><h2>L-spel - spel för surfplatta och telefon</h2><p>Du kan använda huvudmenyn för att välja nästa alternativ i spelet:</p><p>Detta spel kan lagra avslutade/oavslutade spelsessioner med aktuell spelsituation. Välj det alternativet för att se en lista över sparade sessioner och spelbrädor. Du kan också ta bort gamla spelsessioner genom att trycka på papperskorgen på raden. Du kan välja ett oavslutat spel för att fortsätta spelet där spelarna lämnade det valda spelet.</p><h3>Efter att ha startat ett nytt L-spel</h3><p>2 spelare har varsin L-pjäs. Efter att ha flyttat en L-pjäs kan en spelare flytta en av de neutrala pjäserna. Målet med ett drag visas med en svart dragram runt den aktuella L-pjäsen. På den valda neutrala pjäsen är en dragram antingen blå eller röd efter spelare 1 eller 2.</p><p>Och en dragram flyttas runt spelbordet genom att trycka på gula dragknappar. När dragramen är på rätt plats för L-draget, tryck på knappen Drag klart. Om draget har accepterats flyttas pjäsen till den valda positionen. Och draget flyttas runt en neutral pjäs. Du kan ändra en vald neutral pjäs om du vill göra det. När knappen Drag klart har tryckts in 2 gånger ändras spelturen till motsatt spelare och dragramen är runt hans/hennes L-pjäs.</p><p>När talkback-appen för Android inte körs kan du också flytta ramen runt spelbrädet med fingergester istället för gula dragknappar, som:</p><p><b>Svep uppåt eller nedåt</b> = ramen rör sig uppåt eller nedåt.</b><p><b>Svep åt vänster eller höger</b> = ramen rör sig åt vänster eller höger.</p><p><b>2 tryck på spelbrädet</b> = ramen rör sig som om man trycker på knappen \'wrap\'.</p><p><b>Långt tryck på spelbrädet</b> = ramen rör sig som om man trycker på knappen \'vrid 90º\'.</p><p>L-pjäsen för Spelare 1 är markerad med en vit siffra 1 och har färgen röd. Och detsamma för Spelare 2 har markerats med en vit siffra 2 och har färgen blå. 2 neutrala pjäser har svart färg. Och i tur och ordning markeras spelarens L-drag med en svart 1 eller 2 siffra. När ett L-drag accepteras försvinner L-dragramen. Och en neutral dragram skapas runt en neutral knapp. När hela draget är klart (det andra trycket på klart-knappen), flyttas L-dragramen runt en annan L-pjäs för den som står på tur. I denna version av spelet har olika fingergester lagts till över spelbrädet, vilka motsvarar nedtryckta dragknappar: vänstersvep som att trycka på vänsterknappen, högersvep som att trycka på högerknappen, uppsvep som att trycka på uppknappen, nedsvep som att trycka på nedknappen, långt tryck som att trycka på knappen vrid 90º och dubbeltryck som att trycka på knappen wrap,</p><h2>Från Wikipedia</h2><p>Från Wikipedia, den fria encyklopedin. L-spelbräde och startuppställning, med neutrala pjäser visade som svarta diskar:</p></div>';

  @override
  String get helpContent2 =>
      '<div><p>L-spelet är ett enkelt abstrakt strategibrädspel uppfunnet av Edward de Bono. Det introducerades i hans bok The Five-Day Course in Thinking (1967).</p><h3>Beskrivning</h3><p>L-spelet är ett spel för två spelare som spelas på ett bräde med 4×4 rutor. Varje spelare har en 3×2 L-formad tetromino, och det finns två 1×1 neutrala pjäser.</p><h3>Regler</h3><p>Vid varje tur måste en spelare först flytta sin L-pjäs, och kan sedan valfritt flytta någon av de neutrala pjäserna. Spelet vinns genom att lämna motståndaren oförmögen att flytta sin L-pjäs till en ny position.</p></div>';

  @override
  String get helpContent3 =>
      '<div class=\"text\"><p>Pjäser får inte överlappa eller täcka andra pjäser, eller låta pjäserna hamna utanför brädet. När man flyttar L-pjäsen plockas den upp och placeras sedan i tomma rutor var som helst på brädet. Den kan roteras eller till och med vändas när man gör det; den enda regeln är att den måste hamna i en annan position än den position den startade i – och täcker därmed minst en ruta den inte tidigare täckte. För att flytta en neutral pjäs plockar en spelare helt enkelt upp den och placerar den sedan i en tom ruta var som helst på brädet.</p><h1>Strategi</h1><p>En grundläggande strategi är att använda en neutral pjäs och sin egen pjäs för att blockera en 3×3-ruta i ett hörn, och använda en neutral pjäs för att förhindra motståndarens L-pjäs från att byta till en spegelvänd position. En annan grundläggande strategi är att flytta en L-pjäs för att blockera hälften av brädet och använda de neutrala pjäserna för att förhindra motståndarens möjliga alternativa positioner.</p><p>Dessa positioner kan ofta uppnås när en neutral pjäs lämnas i en av de åtta mördarplatserna på brädets omkrets. Mördarplatserna är platserna på omkretsen, men inte i ett hörn. Vid nästa drag gör man antingen den tidigare placerade mördaren till en del av ens ruta, eller använder den för att blockera en omkretsposition, och gör ett kvadrat- eller halvbrädesblock med sitt eget L och en flyttad neutral pjäs.</p><h1>Analys</h1><p>Alla positioner, Röd att flytta, där Röd kommer att förlora mot en perfekt Blå, och maximalt antal drag kvar för Röd. Genom att titta framåt ett drag och se till att man aldrig hamnar i någon av ovanstående positioner kan man undvika att förlora. Alla möjliga slutpositioner, Blå har vunnit</p></div>';

  @override
  String get helpContent4 =>
      '<div class=\"text\"><p>I ett spel med två perfekta spelare kommer ingen någonsin att vinna eller förlora. L-spelet är tillräckligt litet för att vara fullständigt lösbart. Det finns 2296 olika möjliga giltiga sätt pjäserna kan arrangeras på, utan att räkna en rotation eller spegling av ett arrangemang som ett nytt arrangemang, och betrakta de två neutrala pjäserna som identiska. Vilket arrangemang som helst kan nås under spelets gång, oavsett vems tur det är. Varje spelare har förlorat i 15 av dessa arrangemang, om det är den spelarens tur. De förlorande arrangemangen innebär att den förlorande spelarens L-pjäs rör vid ett hörn. Varje spelare kommer också snart att förlora mot en perfekt spelare i ytterligare 14 arrangemang. En spelare kommer att kunna åtminstone tvinga fram oavgjort (genom att spela för evigt utan att förlora) från de återstående 2267 positionerna.</p><p>Även om ingen av spelarna spelar perfekt, kan defensivt spel fortsätta på obestämd tid om spelarna är för försiktiga för att flytta en neutral pjäs till mördarpositionerna. Om båda spelarna är på denna nivå tillåter en sudden death-variant av reglerna att man flyttar båda neutrala pjäserna efter att ha flyttat. En spelare som kan se tre drag framåt kan besegra defensivt spel med standardreglerna.[förtydligande behövs]</p><h1>Referenser</h1><p>\"Games and Puzzles 1974-11: Iss 30\". A H C Publications. November 1974.</p><h1>Andra källor</h1><p>de Bono, Edward (1967). \"The L Game: Strategic Thinking\". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.<p>Parlett, David (1999). \"The L-Game\". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.<p>Pritchard, D. B. (1982). \"The L-Game\". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.</p><h1>Externa länkar</h1><p>L-spel på Edward de Bonos officiella webbplats (arkiverad)<p>Interaktivt webbaserat L-spel skrivet i JavaScript</p><h1>Kategorier:</h1><p>Brädspel introducerade 1968 Abstrakt strategispel Matematiska spel Lösta spel</p></div>';
}
