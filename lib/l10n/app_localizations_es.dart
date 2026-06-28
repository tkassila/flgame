// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get player1MoveLPiece => 'Jugador 1: mueve la pieza L';

  @override
  String get player2MoveLPiece => 'Jugador 2: mueve la pieza L';

  @override
  String get noFreePositionsLPiece =>
      '¡No hay posiciones libres para la pieza L. Has perdido el juego!';

  @override
  String get player1MovedLPiece => 'El Jugador 1 ha movido la pieza L.';

  @override
  String get player2MovedLPiece => 'El Jugador 2 ha movido la pieza L.';

  @override
  String get movedNeutral1Piece => 'El jugador ha movido la pieza neutral 1.';

  @override
  String get movedNeutral2Piece => 'El jugador ha movido la pieza neutral 2.';

  @override
  String get movedNeutralFrame => 'El jugador ha movido el marco neutral.';

  @override
  String get movedLPieceFrame => 'El jugador ha movido el marco L.';

  @override
  String get lPositionIsOld =>
      '¡La posición L es la antigua! Muévela a una posición diferente.';

  @override
  String get lPositionSame =>
      '¡La posición L y el movimiento son iguales! Muévela a una posición diferente.';

  @override
  String get allLPositionsNotFree => '¡Todas las posiciones L están ocupadas!';

  @override
  String get moveOneNeutralPiece => 'Por favor, mueve una pieza neutral';

  @override
  String get neutralPiecePositionNotFree =>
      '¡Esta posición de pieza neutral no está libre!';

  @override
  String get moveOneMoreNeutralPiece =>
      'Por favor, mueve una pieza neutral más';

  @override
  String rowColumnLabel(int row, int col) {
    return 'Fila: $row columna: $col';
  }

  @override
  String get free => 'Libre';

  @override
  String get bottomFree => 'abajo: Libre';

  @override
  String bottomValue(String value) {
    return 'abajo: $value';
  }

  @override
  String get startGame => 'Empezar juego';

  @override
  String get moveDone => 'Movimiento hecho';

  @override
  String get up => 'Arriba';

  @override
  String get down => 'Abajo';

  @override
  String get left => 'Izquierda';

  @override
  String get right => 'Derecha';

  @override
  String get wrap => 'Envolver';

  @override
  String get turn90 => 'Girar 90º';

  @override
  String get help => 'Ayuda';

  @override
  String get selectUnfinishedGames => 'Seleccionar juegos no terminados';

  @override
  String get editPlayerNames => 'Editar nombres de jugadores';

  @override
  String get finishedGames => 'Juegos terminados';

  @override
  String get exitGame => 'Salir del juego';

  @override
  String get aboutGame => 'Acerca del juego';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get player1 => 'Jugador 1';

  @override
  String get player2 => 'Jugador 2';

  @override
  String get saveNames => 'Guardar nombres';

  @override
  String get noSave => 'No guardar';

  @override
  String get newLGame => 'Nuevo juego L';

  @override
  String get cancel => 'Cancelar';

  @override
  String get continue_ => 'Continuar';

  @override
  String get startNewGameQuery => '¿Te gustaría empezar un nuevo juego L?';

  @override
  String get newGameCreated => 'Nuevo juego creado...';

  @override
  String selectNeutral(int num) {
    return 'Seleccionar neutral $num';
  }

  @override
  String playerTurnLabel(String player) {
    return 'Turno: $player';
  }

  @override
  String get aboutLGame => 'Acerca de LGame';

  @override
  String get back => 'Atrás';

  @override
  String get lGameTitle => 'Juego L';

  @override
  String get copyright => 'derechos de autor Tuomas Kassila';

  @override
  String version(String version) {
    return 'versión $version';
  }

  @override
  String get unfinishedGames => 'Juegos no terminados';

  @override
  String get finishedGamesTitle => 'Juegos terminados';

  @override
  String get selectGame => 'Seleccionar juego';

  @override
  String get deleteOldGame => 'Eliminar juego antiguo';

  @override
  String get deleteOldGameQuery => '¿Te gustaría eliminar un juego L antiguo?';

  @override
  String player1Label(String name) {
    return 'Jugador 1: $name';
  }

  @override
  String player2Label(String name) {
    return 'Jugador 2: $name';
  }

  @override
  String get tapToDelete =>
      'Para eliminar esta sesión de juego, toca el icono de la papelera';

  @override
  String get backIntoLGame => 'Volver a LGame';

  @override
  String get scrollHelp =>
      'Desplázate hacia arriba y hacia abajo entre el texto de ayuda. O cuando sea necesario, de arriba hacia abajo.';

  @override
  String get swipeHelp =>
      'Desliza de izquierda a derecha y vuelve entre las páginas de ayuda. O cuando sea necesario, de arriba hacia abajo.';

  @override
  String get startPositionLGame => 'Posición inicial del juego L';

  @override
  String get allPossibleFinalPositions =>
      'Todas las posiciones finales posibles, el azul ha ganado';

  @override
  String get losePositionsDescription =>
      'Todas las posiciones, el rojo mueve, donde el rojo perderá ante un azul perfecto, y el número máximo de movimientos restantes para el rojo. Al mirar un movimiento por delante y asegurarse de que nunca se termine en ninguna de las posiciones anteriores, uno puede evitar perder.';

  @override
  String get finishedGameSemantics => 'Juego terminado';

  @override
  String get unfinishedGameSemantics => 'Juego no terminado';

  @override
  String get finishedGameNameSemantics => 'Nombre del juego terminado';

  @override
  String get unfinishedGameNameSemantics => 'Nombre del juego no terminado';

  @override
  String get loading => 'El juego L se está cargando...';

  @override
  String get finishedGamesHint => 'Lista de juegos terminados';

  @override
  String get unfinishedGamesHint => 'Lista de juegos no terminados';

  @override
  String get finishedGameNameHint => 'Nombre del juego terminado';

  @override
  String get unfinishedGameNameHint => 'Nombre del juego no terminado';

  @override
  String get backButtonHint => 'Botón de atrás';

  @override
  String get selectGameButtonHint => 'Botón de seleccionar juego';

  @override
  String get deleteGameButtonHint => 'Eliminar un juego antiguo';

  @override
  String get startGameButtonHint => 'Botón de empezar juego';

  @override
  String get startGameTooltip =>
      'Empezar un nuevo juego L después del juego terminado.';

  @override
  String get upButtonHint => 'Botón de arriba';

  @override
  String get upTooltip => 'Mover el marco de la pieza L hacia arriba.';

  @override
  String get downButtonHint => 'Botón de abajo';

  @override
  String get downTooltip => 'Mover el marco de la pieza L hacia abajo.';

  @override
  String get leftButtonHint => 'Botón de izquierda';

  @override
  String get leftTooltip => 'Mover el marco de la pieza L hacia la izquierda.';

  @override
  String get rightButtonHint => 'Botón de derecha';

  @override
  String get rightTooltip => 'Mover el marco de la pieza L hacia la derecha.';

  @override
  String get wrapButtonHint => 'Botón de envolver';

  @override
  String get wrapTooltip =>
      'Envolver el marco de la pieza L en el tablero de juego.';

  @override
  String neutralButtonHint(String neutral) {
    return 'Botón de $neutral';
  }

  @override
  String get neutralTooltip =>
      'Cambiar el marco de movimiento a otra pieza de juego neutral.';

  @override
  String get turn90ButtonHint => 'Botón de girar 90º';

  @override
  String get turn90Tooltip =>
      'Girar el marco L 90º en el tablero y prepararse para el siguiente movimiento.';

  @override
  String get helpButtonHint => 'Botón de ayuda';

  @override
  String get helpTooltip => 'Páginas de ayuda para este juego L.';

  @override
  String get moveDoneButtonHint => 'Botón de movimiento hecho';

  @override
  String get moveDoneTooltip =>
      'Cuando el marco de movimiento está en la posición para el siguiente movimiento de pieza.';

  @override
  String get moveDoneScreenReaderTooltip =>
      'El marco de movimiento está en la posición correcta y mueve una pieza L o una pieza neutral a esta posición.';

  @override
  String get messageLabel => 'Mensaje';

  @override
  String get messageLabelHint => 'Etiqueta de mensaje';

  @override
  String get messageTooltip => 'Mensajes de este juego.';

  @override
  String get saveNamesButtonHint => 'Botón de guardar nombres';

  @override
  String get saveNamesTooltip =>
      'Cambiar y guardar los nombres de los jugadores de este juego.';

  @override
  String get noSaveButtonHint => 'Botón de no guardar';

  @override
  String get noSaveTooltip =>
      'No guardar los nombres de los jugadores de este juego.';

  @override
  String get playerNameTooltip =>
      'Un nombre de jugador de este juego de sesión.';

  @override
  String get player1TextFieldHint => 'Campo de texto del Jugador 1';

  @override
  String get player2TextFieldHint => 'Campo de texto del Jugador 2';

  @override
  String get saveGameDataLabel => 'Guardar datos del juego';

  @override
  String get saveGameDataHint => 'Guardar datos del juego para esta sesión web';

  @override
  String get saveGameDataTooltip =>
      'Guardar datos del juego para esta sesión web.';

  @override
  String get remoteGameLabel => 'Juego remoto';

  @override
  String get remoteGameHint => 'Juego remoto';

  @override
  String get remoteGameTooltip => 'Juego remoto';

  @override
  String get cancelButtonHint => 'Botón de cancelar';

  @override
  String get continueButtonHint => 'Botón de continuar';

  @override
  String get helpContent1 =>
      '<div class=\"text\"><h2>Juego L - juego para tablet y teléfono</h2><p>Puedes usar el menú principal para seleccionar las siguientes opciones en el juego:</p><p>Este juego puede almacenar sesiones de juego terminadas o no con la situación actual del juego. Selecciona esa opción para ver una lista de sesiones guardadas y tableros de juego. También puedes eliminar sesiones de juego antiguas pulsando la imagen de la papelera en la fila. Puedes seleccionar algún juego inacabado para continuar el juego donde los jugadores lo dejaron.</p><h3>Después de empezar un nuevo juego L</h3><p>2 jugadores tienen una pieza L cada uno. Después de mover la pieza L, un jugador puede mover una de las piezas neutrales. El objetivo de un movimiento se muestra con un marco de movimiento negro alrededor de la pieza L actual. En la pieza neutral seleccionada, un marco de movimiento es azul o rojo después del jugador 1 o 2.</p><p>Y un marco de movimiento se mueve por la mesa de juego pulsando los botones amarillos de movimiento. Cuando el marco de movimiento esté en el lugar adecuado para el movimiento de la L, pulsa el botón Movimiento hecho. Si el movimiento ha sido aceptado, la pieza se mueve a la posición seleccionada. Y el movimiento se desplaza alrededor de una pieza neutral. Puedes cambiar la pieza neutral seleccionada si lo deseas. Cuando se ha pulsado 2 veces el botón Movimiento hecho, el turno de juego cambia al jugador opuesto y el marco de movimiento está alrededor de su pieza L.</p><p>Cuando la aplicación Android talkback no se está ejecutando, también puedes mover el marco por el tablero de juego con gestos táctiles en lugar de los botones amarillos de movimiento, como:</p><p><b>Deslizar arriba o abajo</b> = el marco se mueve arriba o abajo.</b><p><b>Deslizar izquierda o derecha</b> = el marco se mueve a la izquierda o derecha.</p><p><b>2 toques en el tablero de juego</b> = el marco se mueve como al pulsar el botón \'envolver\'.</p><p><b>Pulsación larga en el tablero de juego</b> = el marco se mueve como al pulsar el botón \'girar 90º\'.</p><p>La pieza L para el Jugador 1 está marcada con un número blanco 1 y tiene color rojo. Y lo mismo para el Jugador 2 ha sido marcada con un número blanco 2 y tiene color azul. 2 piezas neutrales tienen color negro. Y en el turno del jugador, el marco negro de movimiento de la L está marcado con un número negro 1 o 2. Cuando se acepta un movimiento de L, el marco de movimiento de L desaparece. Y se crea un marco de movimiento neutral alrededor de un botón neutral. Cuando se completa todo el movimiento (la segunda pulsación del botón hecho), el marco de movimiento de la L se mueve alrededor de otra pieza L del jugador en turno. En esta versión del juego, se han añadido diferentes gestos táctiles sobre el tablero de juego, que corresponden a los botones de movimiento pulsados: deslizar a la izquierda como pulsar el botón izquierdo, deslizar a la derecha como pulsar el botón derecho, deslizar arriba como pulsar el botón arriba, deslizar abajo como pulsar el botón abajo, pulsación larga como pulsar el botón girar 90º y doble pulsación como pulsar el botón envolver,</p><h2>De Wikipedia</h2><p>De Wikipedia, la enciclopedia libre. Tablero del juego L y posición inicial, con piezas neutrales mostradas como discos negros:</p></div>';

  @override
  String get helpContent2 =>
      '<div><p>El juego L es un sencillo juego de mesa de estrategia abstracta inventado por Edward de Bono. Fue introducido en su libro The Five-Day Course in Thinking (1967).</p><h3>Descripción</h3><p>El juego L es un juego para dos jugadores que se juega en un tablero de 4×4 casillas. Cada jugador tiene un tetrominó en forma de L de 3×2, y hay dos piezas neutrales de 1×1.</p><h3>Reglas</h3><p>En cada turno, un jugador debe primero mover su pieza L, y luego puede opcionalmente mover cualquiera de las piezas neutrales. El juego se gana dejando al oponente incapaz de mover su pieza L a una nueva posición.</p></div>';

  @override
  String get helpContent3 =>
      '<div class=\"text\"><p>Las piezas no pueden solaparse ni cubrir otras piezas, ni salirse del tablero. Al mover la pieza L, se levanta y se coloca en casillas vacías en cualquier lugar del tablero. Puede rotarse o incluso voltearse al hacerlo; la única regla es que debe terminar en una posición diferente de la posición en la que empezó, cubriendo así al menos una casilla que no cubría anteriormente. Para mover una pieza neutral, un jugador simplemente la levanta y la coloca en una casilla vacía en cualquier lugar del tablero.</p><h1>Estrategia</h1><p>Una estrategia básica es usar una pieza neutral y la propia pieza para bloquear un cuadrado de 3×3 en una esquina, y usar una pieza neutral para evitar que la pieza L del oponente cambie a una posición de imagen especular. Otra estrategia básica es mover una pieza L para bloquear la mitad del tablero, y usar las piezas neutrales para evitar las posibles posiciones alternativas del oponente.</p><p>Estas posiciones a menudo se pueden lograr una vez que se deja una pieza neutral en uno de los ocho espacios asesinos en el perímetro del tablero. Los espacios asesinos son los espacios en el perímetro, pero no en una esquina. En el siguiente movimiento, uno hace que el asesino previamente colocado sea parte de su cuadrado, o lo usa para bloquear una posición del perímetro, y hace un bloqueo de cuadrado o de medio tablero con su propia L y una pieza neutral movida.</p><h1>Análisis</h1><p>Todas las posiciones, mueve el Rojo, donde el Rojo perderá ante un Azul perfecto, y el número máximo de movimientos restantes para el Rojo. Al mirar un movimiento por delante y asegurarse de que nunca se termine en ninguna de las posiciones anteriores, uno puede evitar perder. Todas las posibles posiciones finales, el Azul ha ganado</p></div>';

  @override
  String get helpContent4 =>
      '<div class=\"text\"><p>En un juego con dos jugadores perfectos, ninguno ganará ni perderá nunca. El juego L es lo suficientemente pequeño como para ser completamente resoluble. Hay 2296 formas diferentes posibles de organizar las piezas, sin contar una rotación o reflejo de una disposición como una nueva disposición, y considerando las dos piezas neutrales como idénticas. Se puede llegar a cualquier disposición durante el juego, siendo el turno de cualquier jugador. Cada jugador ha perdido en 15 de estas disposiciones, si es el turno de ese jugador. Las disposiciones perdedoras implican que la pieza L del jugador que pierde toca una esquina. Cada jugador también perderá pronto ante un jugador perfecto en otras 14 disposiciones. Un jugador podrá al menos forzar un empate (jugando para siempre sin perder) desde las 2267 posiciones restantes.</p><p>Incluso si ningún jugador juega perfectamente, el juego defensivo puede continuar indefinidamente si los jugadores son demasiado cautelosos para mover una pieza neutral a las posiciones asesinas. Si ambos jugadores están en este nivel, una variante de las reglas de muerte súbita permite mover ambas piezas neutrales después de mover. Un jugador que pueda mirar tres movimientos por delante puede derrotar el juego defensivo usando las reglas estándar.[se necesita aclaración]</p><h1>Referencias</h1><p>\"Games and Puzzles 1974-11: Iss 30\". A H C Publications. Noviembre 1974.</p><h1>Otras fuentes</h1><p>de Bono, Edward (1967). \"The L Game: Strategic Thinking\". The Five-Day Course in Thinking. Basic Books Inc. pp. 149–206. LCCN 67027438.<p>Parlett, David (1999). \"The L-Game\". The Oxford History of Board Games. Oxford University Press Inc. pp. 161–62. ISBN 0-19-212998-8.<p>Pritchard, D. B. (1982). \"The L Game\". Brain Games. Penguin Books Ltd. pp. 107–12. ISBN 0-14-00-5682-3.</p><h1>Enlaces externos</h1><p>Juego L en el sitio oficial de Edward de Bono (archivado)<p>Juego L interactivo basado en la web escrito en JavaScript</p><h1>Categorías:</h1><p>Juegos de mesa introducidos en 1968 Juegos de estrategia abstracta Juegos matemáticos Juegos resueltos</p></div>';
}
