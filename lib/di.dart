import 'package:flgame/models/LGameDataService.dart';

import 'di_ex.dart';

GetIt di = GetIt.instance;

Future<void> setupDi() async {

  /// Hive DataBase
  await Hive.initFlutter();

  /// DB Services
  // Home DataBase Service
  di.registerSingleton<LGameDateService>(LGameDateService());
  await di<LGameDateService>().initHive();
}