// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get player1MoveLPiece => 'Spieler 1: L-Teil bewegen';

  @override
  String get player2MoveLPiece => 'Spieler 2: L-Teil bewegen';

  @override
  String get noFreePositionsLPiece =>
      'Es gibt keine freien Positionen für das L-Teil. Du hast dieses Spiel verloren!';

  @override
  String get player1MovedLPiece => 'Spieler 1 hat das L-Teil bewegt.';

  @override
  String get player2MovedLPiece => 'Spieler 2 hat das L-Teil bewegt.';

  @override
  String get movedNeutral1Piece => 'Spieler hat neutrales Teil 1 bewegt.';

  @override
  String get movedNeutral2Piece => 'Spieler hat neutrales Teil 2 bewegt.';

  @override
  String get movedNeutralFrame => 'Spieler hat den neutralen Rahmen bewegt.';

  @override
  String get movedLPieceFrame => 'Spieler hat den L-Rahmen bewegt.';

  @override
  String get lPositionIsOld =>
      'L-Position ist die alte! In eine andere Position bewegen.';

  @override
  String get lPositionSame =>
      'L-Position und die Bewegung sind gleich! In eine andere Position bewegen.';

  @override
  String get allLPositionsNotFree => 'Alle L-Positionen sind nicht frei!';

  @override
  String get moveOneNeutralPiece => 'Bitte ein neutrales Teil bewegen';

  @override
  String get neutralPiecePositionNotFree =>
      'Diese neutrale Teilposition ist nicht frei!';

  @override
  String get moveOneMoreNeutralPiece =>
      'Bitte ein weiteres neutrales Teil bewegen';

  @override
  String rowColumnLabel(int row, int col) {
    return 'Zeile: $row Spalte: $col';
  }

  @override
  String get free => 'Frei';

  @override
  String get bottomFree => 'unten: Frei';

  @override
  String bottomValue(String value) {
    return 'unten: $value';
  }

  @override
  String get startGame => 'Spiel starten';

  @override
  String get moveDone => 'Zug fertig';

  @override
  String get up => 'Hoch';

  @override
  String get down => 'Runter';

  @override
  String get left => 'Links';

  @override
  String get right => 'Rechts';

  @override
  String get wrap => 'Umfassen';

  @override
  String get turn90 => '90º drehen';

  @override
  String get help => 'Hilfe';

  @override
  String get selectUnfinishedGames => 'Unbeendete Spiele auswählen';

  @override
  String get editPlayerNames => 'Spielernamen bearbeiten';

  @override
  String get finishedGames => 'Beendete Spiele';

  @override
  String get exitGame => 'Spiel beenden';

  @override
  String get aboutGame => 'Über das Spiel';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get player1 => 'Spieler 1';

  @override
  String get player2 => 'Spieler 2';

  @override
  String get saveNames => 'Namen speichern';

  @override
  String get noSave => 'Nicht speichern';

  @override
  String get newLGame => 'Neues L-Spiel';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get continue_ => 'Fortfahren';

  @override
  String get startNewGameQuery => 'Möchten Sie ein neues L-Spiel starten?';

  @override
  String get newGameCreated => 'Neues Spiel erstellt...';

  @override
  String selectNeutral(int num) {
    return 'Neutrales $num auswählen';
  }

  @override
  String playerTurnLabel(String player) {
    return 'Am Zug: $player';
  }

  @override
  String get aboutLGame => 'Über LGame';

  @override
  String get back => 'Zurück';

  @override
  String get lGameTitle => 'L-Spiel';

  @override
  String get copyright => 'Urheberrecht Tuomas Kassila';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get unfinishedGames => 'Unbeendete Spiele';

  @override
  String get finishedGamesTitle => 'Beendete Spiele';

  @override
  String get selectGame => 'Spiel auswählen';

  @override
  String get deleteOldGame => 'Altes Spiel löschen';

  @override
  String get deleteOldGameQuery => 'Möchten Sie ein altes L-Spiel löschen?';

  @override
  String player1Label(String name) {
    return 'Spieler 1: $name';
  }

  @override
  String player2Label(String name) {
    return 'Spieler 2: $name';
  }

  @override
  String get tapToDelete =>
      'Um diese Spielsitzung zu löschen, tippen Sie auf das Mülleimer-Symbol';

  @override
  String get backIntoLGame => 'Zurück zu LGame';

  @override
  String get scrollHelp =>
      'Scrollen Sie zwischen dem Hilfetext nach oben und unten. Oder bei Bedarf von oben nach unten.';

  @override
  String get swipeHelp =>
      'Wischen Sie von links nach rechts und zurück zwischen den Hilfeseiten. Oder bei Bedarf von oben nach unten.';

  @override
  String get startPositionLGame => 'Startposition des L-Spiels';

  @override
  String get allPossibleFinalPositions =>
      'Alle möglichen Endpositionen, Blau hat gewonnen';

  @override
  String get losePositionsDescription =>
      'Alle Positionen, Rot ist am Zug, in denen Rot gegen ein perfektes Blau verliert, und die maximale Anzahl der verbleibenden Züge für Rot. Indem man einen Zug vorausblickt und sicherstellt, dass man nie in einer der oben genannten Positionen landet, kann man das Verlieren vermeiden.';

  @override
  String get finishedGameSemantics => 'Beendetes Spiel';

  @override
  String get unfinishedGameSemantics => 'Unbeendetes Spiel';

  @override
  String get finishedGameNameSemantics => 'Name des beendeten Spiels';

  @override
  String get unfinishedGameNameSemantics => 'Name des unbeendeten Spiels';

  @override
  String get loading => 'L-Spiel wird geladen...';

  @override
  String get finishedGamesHint => 'Liste der beendeten Spiele';

  @override
  String get unfinishedGamesHint => 'Liste der unbeendeten Spiele';

  @override
  String get finishedGameNameHint => 'Name des beendeten Spiels';

  @override
  String get unfinishedGameNameHint => 'Name des unbeendeten Spiels';

  @override
  String get backButtonHint => 'Zurück-Button';

  @override
  String get selectGameButtonHint => 'Spiel auswählen-Button';

  @override
  String get deleteGameButtonHint => 'Ein altes Spiel löschen';

  @override
  String get helpContent1 =>
      '<div class=\"text\"><h2>L-Spiel - Tablet- und Smartphone-Spiel</h2><p>Sie können das Hauptmenü verwenden, um die nächsten Optionen im Spiel auszuwählen:</p><p>Dieses Spiel kann un/beendete Spielsitzungen mit der aktuellen Spielsituation speichern. Wählen Sie diese Option, um eine Liste der gespeicherten Sitzungen und Spielbretter anzuzeigen. Sie können auch alte Spielsitzungen entfernen, indem Sie auf das Mülleimer-Symbol in der Zeile drücken. Sie können ein unvollendetes Spiel auswählen, um das Spiel dort fortzusetzen, wo die Spieler das ausgewählte Spiel verlassen haben.</p><h3>Nach dem Start eines neuen L-Spiels</h3><p>2 Spieler haben jeweils ein L-Teil. Nach dem Bewegen eines L-Teils kann ein Spieler eines der neutralen Teile bewegen. Das Ziel eines Zuges wird mit einem schwarzen Zugrahmen um das aktuelle L-Teil angezeigt. Auf dem ausgewählten neutralen Teil ist ein Zugrahmen entweder blau oder rot nach Spieler 1 oder 2.</p><p>Ein Zugrahmen wird durch Drücken der gelben Zugtasten auf dem Spieltisch bewegt. Wenn sich der Zugrahmen an der richtigen Stelle für den L-Zug befindet, drücken Sie die Taste \'Zug fertig\'. Wenn der Zug akzeptiert wurde, wird das Teil an die ausgewählte Position bewegt. Dann wird der Zug um ein neutrales Teil bewegt. Sie können ein ausgewähltes neutrales Teil ändern, wenn Sie dies tun möchten. Wenn die Taste \'Zug fertig\' 2 Mal gedrückt wurde, wechselt die Spielrunde zum gegnerischen Spieler und der Zugrahmen befindet sich um sein/ihr L-Teil.</p><p>Wenn die Android-Anwendung Talkback nicht ausgeführt wird, können Sie den Rahmen auf dem Spielfeld auch mit Fingergesten anstelle der gelben Zugtasten bewegen, wie z.B.:</p><p><b>Wischen nach oben oder unten</b> = der Rahmen bewegt sich nach oben oder unten.</b><p><b>Wischen nach links oder rechts</b> = der Rahmen bewegt sich nach links oder rechts.</p><p><b>2 Mal auf das Spielfeld tippen</b> = der Rahmen bewegt sich wie beim Drücken der Taste \'Wrap\'.</p><p><b>Langes Drücken auf das Spielfeld</b> = der Rahmen bewegt sich wie beim Drücken der Taste \'90º drehen\'.</p><p>Das L-Teil für Spieler 1 ist mit einer weißen Nummer 1 markiert und hat die Farbe Rot. Das gleiche für Spieler 2 ist mit einer weißen Nummer 2 markiert und hat die Farbe Blau. 2 neutrale Teile haben die Farbe Schwarz. Wenn ein Spieler an der Reihe ist, ist der schwarze Rahmen für den L-Zug mit einer schwarzen 1 oder 2 markiert. Wenn ein L-Zug akzeptiert wird, verschwindet der L-Zugrahmen. Ein neutraler Zugrahmen wird um eine neutrale Taste erstellt. Wenn der gesamte Zug abgeschlossen ist (beim zweiten Drücken der Fertig-Taste), wird der L-Zugrahmen um ein anderes L-Teil des Spielers verschoben, der an der Reihe ist. In dieser Version des Spiels wurden verschiedene Fingergesten über dem Spielfeld hinzugefügt, die den gedrückten Zugtasten entsprechen: Wischen nach links wie Drücken der Links-Taste, Wischen nach rechts wie Drücken der Rechts-Taste, Wischen nach oben wie Drücken der Aufwärts-Taste, Wischen nach unten wie Drücken der Abwärts-Taste, langes Drücken wie Drücken der Taste \'90º drehen\' und doppeltes Tippen wie Drücken der Taste \'Wrap\'.</p><h2>Von Wikipedia</h2><p>Aus Wikipedia, der freien Enzyklopädie. L-Spielbrett und Startaufstellung, mit neutralen Stücken als schwarze Scheiben:</p></div>';

  @override
  String get helpContent2 =>
      '<div><p>Das L-Spiel ist ein einfaches abstraktes Strategie-Brettspiel, das von Edward de Bono erfunden wurde. Es wurde in seinem Buch \'The Five-Day Course in Thinking\' (1967) eingeführt.</p><h3>Beschreibung</h3><p>Das L-Spiel ist ein Spiel für zwei Spieler, das auf einem Brett mit 4×4 Quadraten gespielt wird. Jeder Spieler hat ein 3×2 L-förmiges Tetromino, und es gibt zwei 1×1 neutrale Teile.</p><h3>Regeln</h3><p>In jeder Runde muss ein Spieler zuerst sein L-Teil bewegen und kann dann optional eines der neutralen Teile bewegen. Das Spiel ist gewonnen, wenn der Gegner sein L-Teil nicht mehr auf eine neue Position bewegen kann.</p></div>';

  @override
  String get helpContent3 =>
      '<div class=\"text\"><p>Teile dürfen sich nicht überlappen oder andere Teile abdecken oder die Teile vom Brett lassen. Beim Bewegen des L-Teils wird es aufgehoben und dann in leere Quadrate an einer beliebigen Stelle auf dem Brett platziert. Es kann dabei gedreht oder sogar umgedreht werden; die einzige Regel ist, dass es an einer anderen Position enden muss als der Position, an der es gestartet ist – und somit mindestens ein Quadrat abdeckt, das es zuvor nicht abgedeckt hat. Um ein neutrales Teil zu bewegen, hebt ein Spieler es einfach auf und platziert es dann in einem leeren Quadrat an einer beliebigen Stelle auf dem Brett.</p><h1>Strategie</h1><p>Eine grundlegende Strategie besteht darin, ein neutrales Teil und das eigene Teil zu verwenden, um ein 3×3-Quadrat in einer Ecke zu blockieren, und ein neutrales Teil zu verwenden, um zu verhindern, dass das L-Teil des Gegners in eine spiegelbildliche Position wechselt. Eine andere grundlegende Strategie besteht darin, ein L-Teil zu bewegen, um eine Hälfte des Brettes zu blockieren, und die neutralen Teile zu verwenden, um die möglichen Ausweichpositionen des Gegners zu verhindern.</p><p>Diese Positionen können oft erreicht werden, wenn ein neutrales Teil in einem der acht Killer-Felder am Rand des Brettes gelassen wird. Die Killer-Felder sind die Felder am Rand, aber nicht in einer Ecke. Beim nächsten Zug macht man entweder den zuvor platzierten Killer zu einem Teil des eigenen Quadrats oder verwendet ihn, um eine Randposition zu blockieren, und erstellt mit dem eigenen L und einem bewegten neutralen Teil einen Quadrat- oder Halbbordblock.</p><h1>Analyse</h1><p>Alle Positionen, Rot am Zug, in denen Rot gegen ein perfektes Blau verliert, und die maximale Anzahl der für Rot verbleibenden Züge. Indem man einen Zug vorausblickt und sicherstellt, dass man nie in einer der oben genannten Positionen landet, kann man das Verlieren vermeiden. Alle möglichen Endpositionen, Blau hat gewonnen</p></div>';

  @override
  String get helpContent4 =>
      '<div class=\"text\"><p>In einem Spiel mit zwei perfekten Spielern wird keiner jemals gewinnen oder verlieren. Das L-Spiel ist klein genug, um vollständig lösbar zu sein. Es gibt 2296 verschiedene mögliche gültige Arten, wie die Teile angeordnet werden können, wobei eine Drehung oder Spiegelung einer Anordnung nicht als neue Anordnung gezählt wird und die beiden neutralen Teile als identisch betrachtet werden. Jede Anordnung kann während des Spiels erreicht werden, wobei jeder Spieler am Zug sein kann. Jeder Spieler hat in 15 dieser Anordnungen verloren, wenn dieser Spieler am Zug ist. Die verlierenden Anordnungen beinhalten, dass das L-Teil des verlierenden Spielers eine Ecke berührt. Jeder Spieler wird auch bald gegen einen perfekten Spieler in weiteren 14 Anordnungen verlieren. Ein Spieler wird in der Lage sein, zumindest ein Unentschieden zu erzwingen (indem er ewig spielt, ohne zu verlieren) aus den verbleibenden 2267 Positionen.</p><p>Selbst wenn kein Spieler perfekt spielt, kann das defensive Spiel unbegrenzt fortgesetzt werden, wenn die Spieler zu vorsichtig sind, um ein neutrales Teil in die Killer-Positionen zu bewegen. Wenn beide Spieler auf diesem Niveau sind, erlaubt eine Sudden-Death-Variante der Regeln, beide neutralen Teile nach dem Bewegen zu bewegen. Ein Spieler, der drei Züge vorausblicken kann, kann das defensive Spiel nach den Standardregeln besiegen.[Klärung erforderlich]</p><h1>Referenzen</h1><p>\"Games and Puzzles 1974-11: Iss 30\". A H C Publications. November 1974.</p><h1>Andere Quellen</h1><p>de Bono, Edward (1967). \"The L Game: Strategic Thinking\". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.<p>Parlett, David (1999). \"The L-Game\". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.<p>Pritchard, D. B. (1982). \"The L-Game\". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.</p><h1>Externe Links</h1><p>L-Spiel auf der offiziellen Seite von Edward de Bono (archiviert)<p>Interaktives webbasiertes L-Spiel, geschrieben in JavaScript</p><h1>Kategorien:</h1><p>1968 eingeführte Brettspiele Abstraktes Strategiespiel Mathematische Spiele Gelöste Spiele</p></div>';
}
