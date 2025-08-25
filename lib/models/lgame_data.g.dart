// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lgame_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LGameSessionDataAdapter extends TypeAdapter<LGameSessionData> {
  @override
  final int typeId = 0;

  @override
  LGameSessionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LGameSessionData()
      ..name1 = fields[0] as String
      ..name2 = fields[1] as String
      ..startedAt = fields[2] as String?
      ..isLocal = fields[3] as bool
      ..remoteUser = fields[4] as String?
      ..oldIActiveNeutral = fields[5] as int
      ..oldIArrPlayer1Pieces = (fields[6] as List?)?.cast<int>()
      ..oldIArrPlayer2Pieces = (fields[7] as List?)?.cast<int>()
      ..oldIPlayerNeutral1Piece = fields[8] as int
      ..oldIPlayerNeutral2Piece = fields[9] as int
      ..oldIPlayerMovePieces = (fields[10] as List?)?.cast<int>()
      ..oldPlayerTurn = fields[11] as GamePlayerTurn?
      ..oldInMovingPiece = fields[12] as LGamePieceInMove?
      ..oldIPlayerMove = fields[13] as int?
      ..bGameOver = fields[14] as bool
      ..oldIArrPlayerPossibleMovePieces = (fields[15] as List?)?.cast<int>()
      ..oldIPlayerNeutral1PieceInBeginningMove = fields[16] as int?
      ..oldIPlayerNeutral2PieceInBeginningMove = fields[17] as int?
      ..modifiedAt = fields[18] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, LGameSessionData obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.name1)
      ..writeByte(1)
      ..write(obj.name2)
      ..writeByte(2)
      ..write(obj.startedAt)
      ..writeByte(3)
      ..write(obj.isLocal)
      ..writeByte(4)
      ..write(obj.remoteUser)
      ..writeByte(5)
      ..write(obj.oldIActiveNeutral)
      ..writeByte(6)
      ..write(obj.oldIArrPlayer1Pieces)
      ..writeByte(7)
      ..write(obj.oldIArrPlayer2Pieces)
      ..writeByte(8)
      ..write(obj.oldIPlayerNeutral1Piece)
      ..writeByte(9)
      ..write(obj.oldIPlayerNeutral2Piece)
      ..writeByte(10)
      ..write(obj.oldIPlayerMovePieces)
      ..writeByte(11)
      ..write(obj.oldPlayerTurn)
      ..writeByte(12)
      ..write(obj.oldInMovingPiece)
      ..writeByte(13)
      ..write(obj.oldIPlayerMove)
      ..writeByte(14)
      ..write(obj.bGameOver)
      ..writeByte(15)
      ..write(obj.oldIArrPlayerPossibleMovePieces)
      ..writeByte(16)
      ..write(obj.oldIPlayerNeutral1PieceInBeginningMove)
      ..writeByte(17)
      ..write(obj.oldIPlayerNeutral2PieceInBeginningMove)
      ..writeByte(18)
      ..write(obj.modifiedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LGameSessionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveLGameSessionDataAdapter extends TypeAdapter<HiveLGameSessionData> {
  @override
  final int typeId = 1;

  @override
  HiveLGameSessionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLGameSessionData()
      ..saveTime = fields[0] as DateTime?
      ..unFinishedGames = (fields[1] as List?)?.cast<LGameSessionData>()
      ..finishedGames = (fields[2] as List?)?.cast<LGameSessionData>()
      ..activeGame = fields[3] as LGameSessionData?;
  }

  @override
  void write(BinaryWriter writer, HiveLGameSessionData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.saveTime)
      ..writeByte(1)
      ..write(obj.unFinishedGames)
      ..writeByte(2)
      ..write(obj.finishedGames)
      ..writeByte(3)
      ..write(obj.activeGame);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLGameSessionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GamePlayerTurnAdapter extends TypeAdapter<GamePlayerTurn> {
  @override
  final int typeId = 2;

  @override
  GamePlayerTurn read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GamePlayerTurn.player1;
      case 1:
        return GamePlayerTurn.player2;
      default:
        return GamePlayerTurn.player1;
    }
  }

  @override
  void write(BinaryWriter writer, GamePlayerTurn obj) {
    switch (obj) {
      case GamePlayerTurn.player1:
        writer.writeByte(0);
        break;
      case GamePlayerTurn.player2:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamePlayerTurnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LGamePieceInMoveAdapter extends TypeAdapter<LGamePieceInMove> {
  @override
  final int typeId = 3;

  @override
  LGamePieceInMove read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LGamePieceInMove.LPiece;
      case 1:
        return LGamePieceInMove.neutral;
      default:
        return LGamePieceInMove.LPiece;
    }
  }

  @override
  void write(BinaryWriter writer, LGamePieceInMove obj) {
    switch (obj) {
      case LGamePieceInMove.LPiece:
        writer.writeByte(0);
        break;
      case LGamePieceInMove.neutral:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LGamePieceInMoveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
