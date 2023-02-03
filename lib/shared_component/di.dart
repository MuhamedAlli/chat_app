import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preferences.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  //shared preference instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app Preference instance
  instance.registerLazySingleton<AppPreferences>(
          () => AppPreferences(instance<SharedPreferences>()));
}
