import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('sv')
  ];

  /// No description provided for @player1MoveLPiece.
  ///
  /// In en, this message translates to:
  /// **'Player 1: move L piece'**
  String get player1MoveLPiece;

  /// No description provided for @player2MoveLPiece.
  ///
  /// In en, this message translates to:
  /// **'Player 2: move L piece'**
  String get player2MoveLPiece;

  /// No description provided for @noFreePositionsLPiece.
  ///
  /// In en, this message translates to:
  /// **'There is no free positions for L piece. You had lost this game!'**
  String get noFreePositionsLPiece;

  /// No description provided for @player1MovedLPiece.
  ///
  /// In en, this message translates to:
  /// **'Player 1 has moved L Piece.'**
  String get player1MovedLPiece;

  /// No description provided for @player2MovedLPiece.
  ///
  /// In en, this message translates to:
  /// **'Player 2 has moved L Piece.'**
  String get player2MovedLPiece;

  /// No description provided for @movedNeutral1Piece.
  ///
  /// In en, this message translates to:
  /// **'Player has moved Neutral 1 Piece.'**
  String get movedNeutral1Piece;

  /// No description provided for @movedNeutral2Piece.
  ///
  /// In en, this message translates to:
  /// **'Player has moved Neutral 2 Piece.'**
  String get movedNeutral2Piece;

  /// No description provided for @movedNeutralFrame.
  ///
  /// In en, this message translates to:
  /// **'Player has moved Neutral frame.'**
  String get movedNeutralFrame;

  /// No description provided for @movedLPieceFrame.
  ///
  /// In en, this message translates to:
  /// **'Player has moved L frame.'**
  String get movedLPieceFrame;

  /// No description provided for @lPositionIsOld.
  ///
  /// In en, this message translates to:
  /// **'L position is the old one! Move into diff position.'**
  String get lPositionIsOld;

  /// No description provided for @lPositionSame.
  ///
  /// In en, this message translates to:
  /// **'L position and the move are the same! Move into diff position.'**
  String get lPositionSame;

  /// No description provided for @allLPositionsNotFree.
  ///
  /// In en, this message translates to:
  /// **'All L positions are not free!'**
  String get allLPositionsNotFree;

  /// No description provided for @moveOneNeutralPiece.
  ///
  /// In en, this message translates to:
  /// **'Move one neutral piece, please'**
  String get moveOneNeutralPiece;

  /// No description provided for @neutralPiecePositionNotFree.
  ///
  /// In en, this message translates to:
  /// **'This neutral piece position is not free!'**
  String get neutralPiecePositionNotFree;

  /// No description provided for @moveOneMoreNeutralPiece.
  ///
  /// In en, this message translates to:
  /// **'Move one more neutral piece, please'**
  String get moveOneMoreNeutralPiece;

  /// No description provided for @rowColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'Row: {row} column: {col}'**
  String rowColumnLabel(int row, int col);

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @bottomFree.
  ///
  /// In en, this message translates to:
  /// **'bottom: Free'**
  String get bottomFree;

  /// No description provided for @bottomValue.
  ///
  /// In en, this message translates to:
  /// **'bottom: {value}'**
  String bottomValue(String value);

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start game'**
  String get startGame;

  /// No description provided for @moveDone.
  ///
  /// In en, this message translates to:
  /// **'Move Done'**
  String get moveDone;

  /// No description provided for @up.
  ///
  /// In en, this message translates to:
  /// **'Up'**
  String get up;

  /// No description provided for @down.
  ///
  /// In en, this message translates to:
  /// **'Down'**
  String get down;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get right;

  /// No description provided for @wrap.
  ///
  /// In en, this message translates to:
  /// **'Wrap'**
  String get wrap;

  /// No description provided for @turn90.
  ///
  /// In en, this message translates to:
  /// **'Turn 90º'**
  String get turn90;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @selectUnfinishedGames.
  ///
  /// In en, this message translates to:
  /// **'Select unfinished games'**
  String get selectUnfinishedGames;

  /// No description provided for @editPlayerNames.
  ///
  /// In en, this message translates to:
  /// **'Edit player names'**
  String get editPlayerNames;

  /// No description provided for @finishedGames.
  ///
  /// In en, this message translates to:
  /// **'Finished Games'**
  String get finishedGames;

  /// No description provided for @exitGame.
  ///
  /// In en, this message translates to:
  /// **'Exit Game'**
  String get exitGame;

  /// No description provided for @aboutGame.
  ///
  /// In en, this message translates to:
  /// **'About Game'**
  String get aboutGame;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @player1.
  ///
  /// In en, this message translates to:
  /// **'Player 1'**
  String get player1;

  /// No description provided for @player2.
  ///
  /// In en, this message translates to:
  /// **'Player 2'**
  String get player2;

  /// No description provided for @saveNames.
  ///
  /// In en, this message translates to:
  /// **'Save names'**
  String get saveNames;

  /// No description provided for @noSave.
  ///
  /// In en, this message translates to:
  /// **'No save'**
  String get noSave;

  /// No description provided for @newLGame.
  ///
  /// In en, this message translates to:
  /// **'New L game'**
  String get newLGame;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @startNewGameQuery.
  ///
  /// In en, this message translates to:
  /// **'Would you like to start a new L game?'**
  String get startNewGameQuery;

  /// No description provided for @newGameCreated.
  ///
  /// In en, this message translates to:
  /// **'New game created...'**
  String get newGameCreated;

  /// No description provided for @selectNeutral.
  ///
  /// In en, this message translates to:
  /// **'Select {num}\' neutral'**
  String selectNeutral(int num);

  /// No description provided for @playerTurnLabel.
  ///
  /// In en, this message translates to:
  /// **'Turn: {player}'**
  String playerTurnLabel(String player);

  /// No description provided for @aboutLGame.
  ///
  /// In en, this message translates to:
  /// **'About LGame'**
  String get aboutLGame;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @lGameTitle.
  ///
  /// In en, this message translates to:
  /// **'L Game'**
  String get lGameTitle;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'copyright Tuomas Kassila'**
  String get copyright;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'version {version}'**
  String version(String version);

  /// No description provided for @unfinishedGames.
  ///
  /// In en, this message translates to:
  /// **'Unfinished games'**
  String get unfinishedGames;

  /// No description provided for @finishedGamesTitle.
  ///
  /// In en, this message translates to:
  /// **'Finished games'**
  String get finishedGamesTitle;

  /// No description provided for @selectGame.
  ///
  /// In en, this message translates to:
  /// **'Select game'**
  String get selectGame;

  /// No description provided for @deleteOldGame.
  ///
  /// In en, this message translates to:
  /// **'Delete old game'**
  String get deleteOldGame;

  /// No description provided for @deleteOldGameQuery.
  ///
  /// In en, this message translates to:
  /// **'Would you like to delete an old L game?'**
  String get deleteOldGameQuery;

  /// No description provided for @player1Label.
  ///
  /// In en, this message translates to:
  /// **'Player 1: {name}'**
  String player1Label(String name);

  /// No description provided for @player2Label.
  ///
  /// In en, this message translates to:
  /// **'Player 2: {name}'**
  String player2Label(String name);

  /// No description provided for @tapToDelete.
  ///
  /// In en, this message translates to:
  /// **'To delete this game session, tap the trash can icon'**
  String get tapToDelete;

  /// No description provided for @backIntoLGame.
  ///
  /// In en, this message translates to:
  /// **'Back into LGame'**
  String get backIntoLGame;

  /// No description provided for @scrollHelp.
  ///
  /// In en, this message translates to:
  /// **'Scroll up and down between help text. Or when needed from up into down.'**
  String get scrollHelp;

  /// No description provided for @swipeHelp.
  ///
  /// In en, this message translates to:
  /// **'Swipe from left into right and back between help pages. Or when needed from up into down.'**
  String get swipeHelp;

  /// No description provided for @startPositionLGame.
  ///
  /// In en, this message translates to:
  /// **'Start position of L game'**
  String get startPositionLGame;

  /// No description provided for @allPossibleFinalPositions.
  ///
  /// In en, this message translates to:
  /// **'All possible final positions, Blue has won'**
  String get allPossibleFinalPositions;

  /// No description provided for @losePositionsDescription.
  ///
  /// In en, this message translates to:
  /// **'All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing.'**
  String get losePositionsDescription;

  /// No description provided for @finishedGameSemantics.
  ///
  /// In en, this message translates to:
  /// **'Finished game'**
  String get finishedGameSemantics;

  /// No description provided for @unfinishedGameSemantics.
  ///
  /// In en, this message translates to:
  /// **'Unfinished game'**
  String get unfinishedGameSemantics;

  /// No description provided for @finishedGameNameSemantics.
  ///
  /// In en, this message translates to:
  /// **'Finished game name'**
  String get finishedGameNameSemantics;

  /// No description provided for @unfinishedGameNameSemantics.
  ///
  /// In en, this message translates to:
  /// **'Unfinished game name'**
  String get unfinishedGameNameSemantics;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'L Game is loading...'**
  String get loading;

  /// No description provided for @finishedGamesHint.
  ///
  /// In en, this message translates to:
  /// **'List of finished games'**
  String get finishedGamesHint;

  /// No description provided for @unfinishedGamesHint.
  ///
  /// In en, this message translates to:
  /// **'List of unfinished games'**
  String get unfinishedGamesHint;

  /// No description provided for @finishedGameNameHint.
  ///
  /// In en, this message translates to:
  /// **'Finished game name'**
  String get finishedGameNameHint;

  /// No description provided for @unfinishedGameNameHint.
  ///
  /// In en, this message translates to:
  /// **'Unfinished game name'**
  String get unfinishedGameNameHint;

  /// No description provided for @backButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Back button'**
  String get backButtonHint;

  /// No description provided for @selectGameButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Select game button'**
  String get selectGameButtonHint;

  /// No description provided for @deleteGameButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Delete an old game'**
  String get deleteGameButtonHint;

  /// No description provided for @startGameButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Start game button'**
  String get startGameButtonHint;

  /// No description provided for @startGameTooltip.
  ///
  /// In en, this message translates to:
  /// **'Start a new l game after the finished game.'**
  String get startGameTooltip;

  /// No description provided for @upButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Up button'**
  String get upButtonHint;

  /// No description provided for @upTooltip.
  ///
  /// In en, this message translates to:
  /// **'Move L piece frame into the up.'**
  String get upTooltip;

  /// No description provided for @downButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Down button'**
  String get downButtonHint;

  /// No description provided for @downTooltip.
  ///
  /// In en, this message translates to:
  /// **'Move L piece frame into the down.'**
  String get downTooltip;

  /// No description provided for @leftButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Left button'**
  String get leftButtonHint;

  /// No description provided for @leftTooltip.
  ///
  /// In en, this message translates to:
  /// **'Move L piece frame into the left.'**
  String get leftTooltip;

  /// No description provided for @rightButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Right button'**
  String get rightButtonHint;

  /// No description provided for @rightTooltip.
  ///
  /// In en, this message translates to:
  /// **'Move L piece frame into the right.'**
  String get rightTooltip;

  /// No description provided for @wrapButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Wrap button'**
  String get wrapButtonHint;

  /// No description provided for @wrapTooltip.
  ///
  /// In en, this message translates to:
  /// **'Wrap L piece frame in the game board.'**
  String get wrapTooltip;

  /// No description provided for @neutralButtonHint.
  ///
  /// In en, this message translates to:
  /// **'{neutral} button'**
  String neutralButtonHint(String neutral);

  /// No description provided for @neutralTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change move frame into another neutral game piece.'**
  String get neutralTooltip;

  /// No description provided for @turn90ButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Turn 90º button'**
  String get turn90ButtonHint;

  /// No description provided for @turn90Tooltip.
  ///
  /// In en, this message translates to:
  /// **'Turn l frame 90º in the board and prepare to a next move.'**
  String get turn90Tooltip;

  /// No description provided for @helpButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Help button'**
  String get helpButtonHint;

  /// No description provided for @helpTooltip.
  ///
  /// In en, this message translates to:
  /// **'Help pages for this l game.'**
  String get helpTooltip;

  /// No description provided for @moveDoneButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Move Done button'**
  String get moveDoneButtonHint;

  /// No description provided for @moveDoneTooltip.
  ///
  /// In en, this message translates to:
  /// **'When move frame is in the position in a next piece move.'**
  String get moveDoneTooltip;

  /// No description provided for @moveDoneScreenReaderTooltip.
  ///
  /// In en, this message translates to:
  /// **'Move frame is in the right position and move a L piece or a neutral piece in this position.'**
  String get moveDoneScreenReaderTooltip;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @messageLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Message label'**
  String get messageLabelHint;

  /// No description provided for @messageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Messages of this game.'**
  String get messageTooltip;

  /// No description provided for @saveNamesButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Save names button'**
  String get saveNamesButtonHint;

  /// No description provided for @saveNamesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change and save player\'s names of this game.'**
  String get saveNamesTooltip;

  /// No description provided for @noSaveButtonHint.
  ///
  /// In en, this message translates to:
  /// **'No save button'**
  String get noSaveButtonHint;

  /// No description provided for @noSaveTooltip.
  ///
  /// In en, this message translates to:
  /// **'No save for player\'s names of this game'**
  String get noSaveTooltip;

  /// No description provided for @playerNameTooltip.
  ///
  /// In en, this message translates to:
  /// **'A player\'s name of this session game'**
  String get playerNameTooltip;

  /// No description provided for @player1TextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Player 1 text field'**
  String get player1TextFieldHint;

  /// No description provided for @player2TextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Player 2 text field'**
  String get player2TextFieldHint;

  /// No description provided for @saveGameDataLabel.
  ///
  /// In en, this message translates to:
  /// **'Save game data'**
  String get saveGameDataLabel;

  /// No description provided for @saveGameDataHint.
  ///
  /// In en, this message translates to:
  /// **'Save game data for this web session'**
  String get saveGameDataHint;

  /// No description provided for @saveGameDataTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save game data for this web session.'**
  String get saveGameDataTooltip;

  /// No description provided for @remoteGameLabel.
  ///
  /// In en, this message translates to:
  /// **'Remote game'**
  String get remoteGameLabel;

  /// No description provided for @remoteGameHint.
  ///
  /// In en, this message translates to:
  /// **'Remote game'**
  String get remoteGameHint;

  /// No description provided for @remoteGameTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remote game'**
  String get remoteGameTooltip;

  /// No description provided for @cancelButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Cancel button'**
  String get cancelButtonHint;

  /// No description provided for @continueButtonHint.
  ///
  /// In en, this message translates to:
  /// **'Continue button'**
  String get continueButtonHint;

  /// No description provided for @helpContent1.
  ///
  /// In en, this message translates to:
  /// **'<div class=\"text\"><h2>L game - tablet and phone game</h2><p>You can use main menu to select next options in the game:</p><p>This game can store un/finished game sessions with current game situation. Select that option to see a list of store sessions and game boards. You can also remove old game sessions to press garbage picture on the row. You can select some unfinished game to continue the game where players left the selected game.</p><h3>After started new L game</h3><p>2 player has one L piece on each player. After a move L piece, a player can move one of the neutral pieces. The aim of a move is shown with a black move frame around the current L piece. On the selected neutral piece, a move frame is either blue or red after the player 1 or 2.</p><p>And a move frame is moving around the game table by pressing on move yellow buttons. When the move frame is on right place for the L move, press Move done -button. If the move has accepted, the piece is moved into the selected position. And the move is moved around a neutral piece. You can change a selected neutral piece, if you will do that. When the move done -button has pressed 2 times, the game turn is changed into opposite player and the move frame is around his/her L piece.</p><p>When tallback android application is not running, you can move frame around game board also with finger gestures instead of yellow move buttons, like:</p><p><b>Up or down swipe</b> = the frame is moving up or down.</b><p><b>Left or right swipe</b> = the frame is moving left or right.</p><p><b>2 tap on the game board</b> = the frame is moving like in pressing \'wrap\' button.</p><p><b>Long press on the game board</b> = the frame is moving like in pressing \'turn 90º\' button.</p><p>The L piece for Player 1 has marked with one white number 1 and has color red. And the same for Player 2 has been marked with one white number 2 and has color blue. 2 neutral pieces has black color. And in turn player\'s L move black frame is marked with black 1 or 2 number. When a L move is accepted, then L move frame disappears. And one neutral move frame is created around one neutral button. When the hole move is done (the second done button press), then the L move frame is moved around another L piece of in turn up\'s. In this version of the game, there are added different finger gestures over game board, which are corresponding pressed move buttons: left swipe like press left button, right swipe like press right button, up swipe like press up button, down swipe like press down button, long press like press turn 90º button and double press like press wrap button,</p><h2>From Wikipedia</h2><p>From Wikipedia, the free encyclopedia L game board and starting setup, with neutral pieces shown as black discs:</p></div>'**
  String get helpContent1;

  /// No description provided for @helpContent2.
  ///
  /// In en, this message translates to:
  /// **'<div><p>The L game is a simple abstract strategy board game invented by Edward de Bono. It was introduced in his book The Five-Day Course in Thinking (1967).</p><h3>Description</h3><p>The L game is a two-player game played on a board of 4×4 squares. Each player has a 3×2 L-shaped tetromino, and there are two 1×1 neutral pieces.</p><h3>Rules</h3><p>On each turn, a player must first move their L piece, and then may optionally move either one of the neutral pieces. The game is won by leaving the opponent unable to move their L piece to a new position.</p></div>'**
  String get helpContent2;

  /// No description provided for @helpContent3.
  ///
  /// In en, this message translates to:
  /// **'<div class=\"text\"><p>Pieces may not overlap or cover other pieces, or let the pieces off the board. On moving the L piece, it is picked up and then placed in empty squares anywhere on the board. It may be rotated or even flipped over in doing so; the only rule is that it must end in a different position from the position it started—thus covering at least one square it did not previously cover. To move a neutral piece, a player simply picks it up then places it in an empty square anywhere on the board.</p><h1>Strategy</h1><p>One basic strategy is to use a neutral piece and one\'s own piece to block a 3×3 square in one corner, and use a neutral piece to prevent the opponent\'s L piece from swapping to a mirror-image position. Another basic strategy is to move an L piece to block a half of the board, and use the neutral pieces to prevent the opponent\'s possible alternate positions.</p><p>These positions can often be achieved once a neutral piece is left in one of the eight killer spaces on the perimeter of the board. The killer spaces are the spaces on the perimeter, but not in a corner. On the next move, one either makes the previously placed killer a part of one\'s square, or uses it to block a perimeter position, and makes a square or half-board block with one\'s own L and a moved neutral piece.</p><h1>Analysis</h1><p>All positions, Red to move, where Red will lose to a perfect Blue, and maximum number of moves remaining for Red. By looking ahead one move and ensuring one never ends up in any of the above positions, one can avoid losing. All possible final positions, Blue has won</p></div>'**
  String get helpContent3;

  /// No description provided for @helpContent4.
  ///
  /// In en, this message translates to:
  /// **'<div class=\"text\"><p>In a game with two perfect players, neither will ever win or lose. The L game is small enough to be completely solvable. There are 2296 different possible valid ways the pieces can be arranged, not counting a rotation or mirror of an arrangement as a new arrangement, and considering the two neutral pieces to be identical. Any arrangement can be reached during the game, with it being any player\'s turn. Each player has lost in 15 of these arrangements, if it is that player\'s turn. The losing arrangements involve the losing player\'s L piece touching a corner. Each player will also soon lose to a perfect player in an additional 14 arrangements. A player will be able to at least force a draw (by playing forever without losing) from the remaining 2267 positions.</p><p>Even if neither player plays perfectly, defensive play can continue indefinitely if the players are too cautious to move a neutral piece to the killer positions. If both players are at this level, a sudden-death variant of the rules permits one to move both neutral pieces after moving. A player who can look three moves ahead can defeat defensive play using the standard rules.[clarification needed]</p><h1>References</h1><p>\"Games and Puzzles 1974-11: Iss 30\". A H C Publications. November 1974.</p><h1>Other sources</h1><p>de Bono, Edward (1967). \"The L Game: Strategic Thinking\". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.<p>Parlett, David (1999). \"The L-Game\". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.<p>Pritchard, D. B. (1982). \"The L Game\". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.</p><h1>External links</h1><p>L game on Edward de Bono\'s official site (archived)<p>Interactive web-based L game written in JavaScript</p><h1>Categories:</h1><p>Board games introduced in 1968Abstract strategy gamesMathematical gamesSolved games</p></div>'**
  String get helpContent4;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fi', 'sv'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
