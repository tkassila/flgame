// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lgame_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LGameSessionDataAdapter extends TypeAdapter<LGameSessionData> {
  @override
  final typeId = 0;

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
      ..remoteUserName1 = fields[4] as String?
      ..oldIActiveNeutral = (fields[5] as num).toInt()
      ..oldIArrPlayer1Pieces = (fields[6] as List?)?.cast<int>()
      ..oldIArrPlayer2Pieces = (fields[7] as List?)?.cast<int>()
      ..oldIPlayerNeutral1Piece = (fields[8] as num).toInt()
      ..oldIPlayerNeutral2Piece = (fields[9] as num).toInt()
      ..oldIPlayerMovePieces = (fields[10] as List?)?.cast<int>()
      ..oldPlayerTurn = fields[11] as GamePlayerTurn?
      ..oldInMovingPiece = fields[12] as LGamePieceInMove?
      ..oldIPlayerMove = (fields[13] as num?)?.toInt()
      ..bGameOver = fields[14] as bool
      ..oldIArrPlayerPossibleMovePieces = (fields[15] as List?)?.cast<int>()
      ..oldIPlayerNeutral1PieceInBeginningMove = (fields[16] as num?)?.toInt()
      ..oldIPlayerNeutral2PieceInBeginningMove = (fields[17] as num?)?.toInt()
      ..modifiedAt = fields[18] as DateTime?
      ..msg = fields[19] as String?
      ..remoteUserName2 = fields[20] as String?
      ..remoteUserId1 = (fields[21] as num?)?.toInt()
      ..remoteUserId2 = (fields[22] as num?)?.toInt()
      ..remoteGameId = (fields[23] as num?)?.toInt()
      ..remoteGameStartedAt = fields[24] as String?;
  }

  @override
  void write(BinaryWriter writer, LGameSessionData obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.name1)
      ..writeByte(1)
      ..write(obj.name2)
      ..writeByte(2)
      ..write(obj.startedAt)
      ..writeByte(3)
      ..write(obj.isLocal)
      ..writeByte(4)
      ..write(obj.remoteUserName1)
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
      ..write(obj.modifiedAt)
      ..writeByte(19)
      ..write(obj.msg)
      ..writeByte(20)
      ..write(obj.remoteUserName2)
      ..writeByte(21)
      ..write(obj.remoteUserId1)
      ..writeByte(22)
      ..write(obj.remoteUserId2)
      ..writeByte(23)
      ..write(obj.remoteGameId)
      ..writeByte(24)
      ..write(obj.remoteGameStartedAt);
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
  final typeId = 1;

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
  final typeId = 2;

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
      case GamePlayerTurn.player2:
        writer.writeByte(1);
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
  final typeId = 3;

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
      case LGamePieceInMove.neutral:
        writer.writeByte(1);
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
