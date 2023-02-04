import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared_component/icon_broken.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SocialMainCubit>(context).getUserData();
    return BlocConsumer<SocialMainCubit, SocialMainState>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var model = BlocProvider.of<SocialMainCubit>(context).userModel;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Post",
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
                onPressed: () {
                  BlocProvider.of<SocialMainCubit>(context).createPost(
                    textEditingController.text,
                      DateFormat.yMMMEd().format(DateTime.now()),
                    model!.uid!,
                    model.username!,
                    model.image!,
                  );
                },
                child: Text(
                  "POST",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Colors.blue, fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (state is SocialLoadingCreatePostState)
                  const LinearProgressIndicator(),
                if (state is SocialLoadingCreatePostState)
                  const SizedBox(
                    height: 5.0,
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage(model == null ? "" : model.image!),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      model == null ? "" : model.username!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    maxLines: 8,
                    maxLength: 500,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "what's in your mind..? ",
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
//
                if (BlocProvider.of<SocialMainCubit>(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: FileImage(
                                  BlocProvider.of<SocialMainCubit>(context)
                                      .postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blueAccent,
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<SocialMainCubit>(context)
                                .removePostImgae();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
//
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<SocialMainCubit>(context)
                                .getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                                size: 25,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Add Photo",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "# Tags",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
