// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get player1MoveLPiece => 'Player 1: move L piece';

  @override
  String get player2MoveLPiece => 'Player 2: move L piece';

  @override
  String get noFreePositionsLPiece =>
      'There is no free positions for L piece. You had lost this game!';

  @override
  String get player1MovedLPiece => 'Player 1 has moved L Piece.';

  @override
  String get player2MovedLPiece => 'Player 2 has moved L Piece.';

  @override
  String get movedNeutral1Piece => 'Player has moved Neutral 1 Piece.';

  @override
  String get movedNeutral2Piece => 'Player has moved Neutral 2 Piece.';

  @override
  String get movedNeutralFrame => 'Player has moved Neutral frame.';

  @override
  String get movedLPieceFrame => 'Player has moved L frame.';

  @override
  String get lPositionIsOld =>
      'L position is the old one! Move into diff position.';

  @override
  String get lPositionSame =>
      'L position and the move are the same! Move into diff position.';

  @override
  String get allLPositionsNotFree => 'All L positions are not free!';

  @override
  String get moveOneNeutralPiece => 'Move one neutral piece, please';

  @override
  String get neutralPiecePositionNotFree =>
      'This neutral piece position is not free!';

  @override
  String get moveOneMoreNeutralPiece => 'Move one more neutral piece, please';

  @override
  String rowColumnLabel(int row, int col) {
    return 'Row: $row column: $col';
  }

  @override
  String get free => 'Free';

  @override
  String get bottomFree => 'bottom: Free';

  @override
  String bottomValue(String value) {
    return 'bottom: $value';
  }

  @override
  String get startGame => 'Start game';

  @override
  String get moveDone => 'Move Done';

  @override
  String get up => 'Up';

  @override
  String get down => 'Down';

  @override
  String get left => 'Left';

  @override
  String get right => 'Right';

  @override
  String get wrap => 'Wrap';

  @override
  String get turn90 => 'Turn 90º';

  @override
  String get help => 'Help';

  @override
  String get selectUnfinishedGames => 'Select unfinished games';

  @override
  String get editPlayerNames => 'Edit player names';

  @override
  String get finishedGames => 'Finished Games';

  @override
  String get exitGame => 'Exit Game';

  @override
  String get aboutGame => 'About Game';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get player1 => 'Player 1';

  @override
  String get player2 => 'Player 2';

  @override
  String get saveNames => 'Save names';

  @override
  String get noSave => 'No save';

  @override
  String get newLGame => 'New L game';

  @override
  String get cancel => 'Cancel';

  @override
  String get continue_ => 'Continue';

  @override
  String get startNewGameQuery => 'Would you like to start a new L game?';

  @override
  String get newGameCreated => 'New game created...';

  @override
  String selectNeutral(int num) {
    return 'Select $num\' neutral';
  }

  @override
  String playerTurnLabel(String player) {
    return 'Turn: $player';
  }

  @override
  String get aboutLGame => 'About LGame';

  @override
  String get back => 'Back';

  @override
  String get lGameTitle => 'L Game';

  @override
  String get copyright => 'copyright Tuomas Kassila';

  @override
  String version(String version) {
    return 'version $version';
  }

  @override
  String get unfinishedGames => 'Unfinished games';

  @override
  String get finishedGamesTitle => 'Finished games';

  @override
  String get selectGame => 'Select game';

  @override
  String get deleteOldGame => 'Delete old game';

  @override
  String get deleteOldGameQuery => 'Would you like to delete an old L game?';

  @override
  String player1Label(String name) {
    return 'Player 1: $name';
  }

  @override
  String player2Label(String name) {
    return 'Player 2: $name';
  }

  @override
  String get tapToDelete =>
      'To delete this game session, tap the trash can icon';

  @override
  String get backIntoLGame => 'Back into LGame';

  @override
  String get scrollHelp =>
      'Scroll up and down between help text. Or when needed from up into down.';

  @override
  String get swipeHelp =>
      'Swipe from left into right and back between help pages. Or when needed from up into down.';

  @override
  String get startPositionLGame => 'Start position of L game';

  @override
  String get allPossibleFinalPositions =>
      'All possible final positions, Blue has won';

  @override
  String get losePositionsDescription =>
      'All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing.';

  @override
  String get finishedGameSemantics => 'Finished game';

  @override
  String get unfinishedGameSemantics => 'Unfinished game';

  @override
  String get finishedGameNameSemantics => 'Finished game name';

  @override
  String get unfinishedGameNameSemantics => 'Unfinished game name';

  @override
  String get loading => 'L Game is loading...';

  @override
  String get finishedGamesHint => 'List of finished games';

  @override
  String get unfinishedGamesHint => 'List of unfinished games';

  @override
  String get finishedGameNameHint => 'Finished game name';

  @override
  String get unfinishedGameNameHint => 'Unfinished game name';

  @override
  String get backButtonHint => 'Back button';

  @override
  String get selectGameButtonHint => 'Select game button';

  @override
  String get deleteGameButtonHint => 'Delete an old game';

  @override
  String get startGameButtonHint => 'Start game button';

  @override
  String get startGameTooltip => 'Start a new l game after the finished game.';

  @override
  String get upButtonHint => 'Up button';

  @override
  String get upTooltip => 'Move L piece frame into the up.';

  @override
  String get downButtonHint => 'Down button';

  @override
  String get downTooltip => 'Move L piece frame into the down.';

  @override
  String get leftButtonHint => 'Left button';

  @override
  String get leftTooltip => 'Move L piece frame into the left.';

  @override
  String get rightButtonHint => 'Right button';

  @override
  String get rightTooltip => 'Move L piece frame into the right.';

  @override
  String get wrapButtonHint => 'Wrap button';

  @override
  String get wrapTooltip => 'Wrap L piece frame in the game board.';

  @override
  String neutralButtonHint(String neutral) {
    return '$neutral button';
  }

  @override
  String get neutralTooltip =>
      'Change move frame into another neutral game piece.';

  @override
  String get turn90ButtonHint => 'Turn 90º button';

  @override
  String get turn90Tooltip =>
      'Turn l frame 90º in the board and prepare to a next move.';

  @override
  String get helpButtonHint => 'Help button';

  @override
  String get helpTooltip => 'Help pages for this l game.';

  @override
  String get moveDoneButtonHint => 'Move Done button';

  @override
  String get moveDoneTooltip =>
      'When move frame is in the position in a next piece move.';

  @override
  String get moveDoneScreenReaderTooltip =>
      'Move frame is in the right position and move a L piece or a neutral piece in this position.';

  @override
  String get messageLabel => 'Message';

  @override
  String get messageLabelHint => 'Message label';

  @override
  String get messageTooltip => 'Messages of this game.';

  @override
  String get saveNamesButtonHint => 'Save names button';

  @override
  String get saveNamesTooltip =>
      'Change and save player\'s names of this game.';

  @override
  String get noSaveButtonHint => 'No save button';

  @override
  String get noSaveTooltip => 'No save for player\'s names of this game';

  @override
  String get playerNameTooltip => 'A player\'s name of this session game';

  @override
  String get player1TextFieldHint => 'Player 1 text field';

  @override
  String get player2TextFieldHint => 'Player 2 text field';

  @override
  String get saveGameDataLabel => 'Save game data';

  @override
  String get saveGameDataHint => 'Save game data for this web session';

  @override
  String get saveGameDataTooltip => 'Save game data for this web session.';

  @override
  String get remoteGameLabel => 'Remote game';

  @override
  String get remoteGameHint => 'Remote game';

  @override
  String get remoteGameTooltip => 'Remote game';

  @override
  String get cancelButtonHint => 'Cancel button';

  @override
  String get continueButtonHint => 'Continue button';

  @override
  String get helpContent1 =>
      '<div class=\"text\"><h2>L game - tablet and phone game</h2><p>You can use main menu to select next options in the game:</p><p>This game can store un/finished game sessions with current game situation. Select that option to see a list of store sessions and game boards. You can also remove old game sessions to press garbage picture on the row. You can select some unfinished game to continue the game where players left the selected game.</p><h3>After started new L game</h3><p>2 player has one L piece on each player. After a move L piece, a player can move one of the neutral pieces. The aim of a move is shown with a black move frame around the current L piece. On the selected neutral piece, a move frame is either blue or red after the player 1 or 2.</p><p>And a move frame is moving around the game table by pressing on move yellow buttons. When the move frame is on right place for the L move, press Move done -button. If the move has accepted, the piece is moved into the selected position. And the move is moved around a neutral piece. You can change a selected neutral piece, if you will do that. When the move done -button has pressed 2 times, the game turn is changed into opposite player and the move frame is around his/her L piece.</p><p>When tallback android application is not running, you can move frame around game board also with finger gestures instead of yellow move buttons, like:</p><p><b>Up or down swipe</b> = the frame is moving up or down.</b><p><b>Left or right swipe</b> = the frame is moving left or right.</p><p><b>2 tap on the game board</b> = the frame is moving like in pressing \'wrap\' button.</p><p><b>Long press on the game board</b> = the frame is moving like in pressing \'turn 90º\' button.</p><p>The L piece for Player 1 has marked with one white number 1 and has color red. And the same for Player 2 has been marked with one white number 2 and has color blue. 2 neutral pieces has black color. And in turn player\'s L move black frame is marked with black 1 or 2 number. When a L move is accepted, then L move frame disappears. And one neutral move frame is created around one neutral button. When the hole move is done (the second done button press), then the L move frame is moved around another L piece of in turn up\'s. In this version of the game, there are added different finger gestures over game board, which are corresponding pressed move buttons: left swipe like press left button, right swipe like press right button, up swipe like press up button, down swipe like press down button, long press like press turn 90º button and double press like press wrap button,</p><h2>From Wikipedia</h2><p>From Wikipedia, the free encyclopedia L game board and starting setup, with neutral pieces shown as black discs:</p></div>';

  @override
  String get helpContent2 =>
      '<div><p>The L game is a simple abstract strategy board game invented by Edward de Bono. It was introduced in his book The Five-Day Course in Thinking (1967).</p><h3>Description</h3><p>The L game is a two-player game played on a board of 4×4 squares. Each player has a 3×2 L-shaped tetromino, and there are two 1×1 neutral pieces.</p><h3>Rules</h3><p>On each turn, a player must first move their L piece, and then may optionally move either one of the neutral pieces. The game is won by leaving the opponent unable to move their L piece to a new position.</p></div>';

  @override
  String get helpContent3 =>
      '<div class=\"text\"><p>Pieces may not overlap or cover other pieces, or let the pieces off the board. On moving the L piece, it is picked up and then placed in empty squares anywhere on the board. It may be rotated or even flipped over in doing so; the only rule is that it must end in a different position from the position it started—thus covering at least one square it did not previously cover. To move a neutral piece, a player simply picks it up then places it in an empty square anywhere on the board.</p><h1>Strategy</h1><p>One basic strategy is to use a neutral piece and one\'s own piece to block a 3×3 square in one corner, and use a neutral piece to prevent the opponent\'s L piece from swapping to a mirror-image position. Another basic strategy is to move an L piece to block a half of the board, and use the neutral pieces to prevent the opponent\'s possible alternate positions.</p><p>These positions can often be achieved once a neutral piece is left in one of the eight killer spaces on the perimeter of the board. The killer spaces are the spaces on the perimeter, but not in a corner. On the next move, one either makes the previously placed killer a part of one\'s square, or uses it to block a perimeter position, and makes a square or half-board block with one\'s own L and a moved neutral piece.</p><h1>Analysis</h1><p>All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing. All possible final positions, Blue has won</p></div>';

  @override
  String get helpContent4 =>
      '<div class=\"text\"><p>In a game with two perfect players, neither will ever win or lose. The L game is small enough to be completely solvable. There are 2296 different possible valid ways the pieces can be arranged, not counting a rotation or mirror of an arrangement as a new arrangement, and considering the two neutral pieces to be identical. Any arrangement can be reached during the game, with it being any player\'s turn. Each player has lost in 15 of these arrangements, if it is that player\'s turn. The losing arrangements involve the losing player\'s L piece touching a corner. Each player will also soon lose to a perfect player in an additional 14 arrangements. A player will be able to at least force a draw (by playing forever without losing) from the remaining 2267 positions.</p><p>Even if neither player plays perfectly, defensive play can continue indefinitely if the players are too cautious to move a neutral piece to the killer positions. If both players are at this level, a sudden-death variant of the rules permits one to move both neutral pieces after moving. A player who can look three moves ahead can defeat defensive play using the standard rules.[clarification needed]</p><h1>References</h1><p>\"Games and Puzzles 1974-11: Iss 30\". A H C Publications. November 1974.</p><h1>Other sources</h1><p>de Bono, Edward (1967). \"The L Game: Strategic Thinking\". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.<p>Parlett, David (1999). \"The L-Game\". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.<p>Pritchard, D. B. (1982). \"The L Game\". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.</p><h1>External links</h1><p>L game on Edward de Bono\'s official site (archived)<p>Interactive web-based L game written in JavaScript</p><h1>Categories:</h1><p>Board games introduced in 1968Abstract strategy gamesMathematical gamesSolved games</p></div>';
}
