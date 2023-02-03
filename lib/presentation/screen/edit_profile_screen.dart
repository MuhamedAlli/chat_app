import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared_component/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SocialMainCubit>(context).getUserData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(IconBroken.Arrow___Left_2),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "UPDATE",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.blue),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<SocialMainCubit, SocialMainState>(
          listener: (context, state) {},
          builder: (context, state) {
            var model = BlocProvider.of<SocialMainCubit>(context).userModel;
            var profileImage =
                BlocProvider.of<SocialMainCubit>(context).profileImage;
            var coverImage =
                BlocProvider.of<SocialMainCubit>(context).coverImage;
            nameController.text = model == null ? "" : model.username!;

            bioController.text = model == null ? "" : model.bio!;
            phoneController.text = model == null ? "" : model.phone!;

            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  topLeft: Radius.circular(5.0),
                                ),
                                image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(model == null
                                            ? "https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg"
                                            : model.cover!)
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blueAccent,
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<SocialMainCubit>(context)
                                      .getCoverImage();
                                },
                                icon: const Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(model == null
                                      ? "https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg"
                                      : model.image!)
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.blueAccent,
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<SocialMainCubit>(context)
                                    .getProfileImage();
                              },
                              icon: const Icon(
                                IconBroken.Camera,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  enabled: true,
                  validator: (name) {
                    if (name != null) {
                      if (name.isEmpty) {
                        return "name must not be empty";
                      }
                      return null;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: SizedBox(
                      width: 50,
                      child: Icon(
                        IconBroken.User,
                      ),
                    ),
                    hintStyle: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.name,
                  enabled: true,
                  validator: (bio) {
                    if (bio != null) {
                      if (bio.isEmpty) {
                        return "bio must not be empty";
                      }
                      return null;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Bio",
                    prefixIcon: SizedBox(
                      width: 50,
                      child: Icon(
                        IconBroken.Info_Circle,
                      ),
                    ),
                    hintStyle: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  enabled: true,
                  validator: (phone) {
                    if (phone != null) {
                      if (phone.isEmpty) {
                        return "phone must not be empty";
                      }
                      return null;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Phone",
                    prefixIcon: SizedBox(
                      width: 50,
                      child: Icon(
                        IconBroken.Call,
                      ),
                    ),
                    hintStyle: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
