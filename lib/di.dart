import 'package:flgame/models/LGameDataService.dart';
import 'services/AudioPlayerService.dart';

import 'di_ex.dart';

GetIt di = GetIt.instance;

Future<void> setupDi() async {

  /// Hive DataBase
  await Hive.initFlutter();

  /// DB Services
  // Home DataBase Service
  di.registerSingleton<LGameDataService>(LGameDataService());
  await di<LGameDataService>().initHive();
  di.registerSingleton<AudioPlayerService>(AudioPlayerService());
}
