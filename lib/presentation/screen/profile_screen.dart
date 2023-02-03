import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_component/icon_broken.dart';
import '../resources/routes_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SocialMainCubit>(context).getUserData();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<SocialMainCubit, SocialMainState>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = BlocProvider.of<SocialMainCubit>(context).userModel;
          return Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            topLeft: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(model!.cover!),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 45.0,
                        backgroundImage: NetworkImage(
                          model.image!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                model.username!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                model.bio!,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "245",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                        Text(
                          "photos",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "100",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                        Text(
                          "Posts",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "10k",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                        Text(
                          "Followers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "10",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                        Text(
                          "Following",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Add Post",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              height: 1.5,
                              color: Colors.blueAccent,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.editProfileScreen,
                            arguments: model);
                      },
                      child: const Icon(
                        IconBroken.Edit,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
