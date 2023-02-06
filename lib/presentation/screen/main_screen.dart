import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:chat_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_component/icon_broken.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<SocialMainCubit>(context);
    return BlocConsumer<SocialMainCubit, SocialMainState>(
      listener: (context, state) {
        if (state is SocialSignOutState) {
          Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
        }
        if (state is SocialAddPostState) {
          Navigator.of(context).pushNamed(Routes.addPostRoute);
        }
      },
      builder: (context, state) {
        BlocProvider.of<SocialMainCubit>(context).getUserData();
        //print(BlocProvider.of<SocialMainCubit>(context).userModel);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              appCubit.titles[appCubit.currentIndex],
              style: Theme.of(context).textTheme.bodySmall,
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  IconBroken.Notification,
                  size: 25,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  IconBroken.Search,
                  size: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    appCubit.onSignOut();
                  },
                  child: const Icon(
                    IconBroken.Logout,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          body: appCubit.widgets[appCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appCubit.currentIndex,
            onTap: (index) {
              appCubit.changeCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                    size: 28,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                    size: 28,
                  ),
                  label: "Chats"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Arrow___Up_Square,
                    size: 28,
                  ),
                  label: "Add Post"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.User1,
                    size: 28,
                  ),
                  label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Profile,
                    size: 28,
                  ),
                  label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
