import 'package:chat_app/presentation/resources/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'presentation/resources/routes_manager.dart';
import 'shared_component/di.dart';
import 'shared_component/preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  }).onError((error) {
    print(error);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data);
  }).onError((error) {
    print(error);
  });
  AppPreferences appPreferences = instance();
  uidValue = appPreferences.getUid();
  //String initialRoute = Routes.loginRoute;
  //print(uidValue);
  /*if (uidValue != null) {
    if (uidValue!.isNotEmpty) {
      initialRoute = Routes.mainRoute;
    }
  } else {
    initialRoute = Routes.loginRoute;
  }**/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final String initialRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialRoute: Routes.mainRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      /*home: uidValue != null
          ? BlocProvider(
              create: (context) => SocialMainCubit(), child: const MainScreen())
          : BlocProvider(
              create: (context) => LoginBloc(), child: const LoginScreen()),*/
    );
  }
}
