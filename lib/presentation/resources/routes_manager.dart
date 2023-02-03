import 'package:chat_app/business_logic/bloc/bloc/login_bloc/login_bloc.dart';
import 'package:chat_app/business_logic/bloc/bloc/register_bloc/register_bloc.dart';
import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:chat_app/presentation/screen/add_post_screen.dart';
import 'package:chat_app/presentation/screen/main_screen.dart';
import 'package:chat_app/presentation/screen/login_screen.dart';
import 'package:chat_app/presentation/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen/edit_profile_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/loginRoute";
  static const String registerRoute = "/registerRoute";
  static const String mainRoute = "/mainRoute";
  static const String homeRoute = "/homeRoute";
  static const String addPostroute = "/addPostroute";
  static const String editProfileScreen = "/editProfileScreen";

  static const String storeDetailsRoute = "/storeDetailsRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: ((_) => BlocProvider(
                create: (context) => LoginBloc(),
                child: const LoginScreen(),
              )),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: ((_) => BlocProvider(
                create: (context) => SocialMainCubit(),
                child: const MainScreen(),
              )),
        );
      case Routes.editProfileScreen:
        return MaterialPageRoute(
          builder: ((_) => BlocProvider(
                create: (context) => SocialMainCubit(),
                child: EditProfileScreen(),
              )),
        );
      case Routes.addPostroute:
        return MaterialPageRoute(
          builder: ((_) => const AddPostScreen()),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: ((_) => BlocProvider(
                create: (context) => RegisterBloc(),
                child: const RegisterScreen(),
              )),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text("No Route Found"),
              ),
            )));
  }
}
