import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:chat_app/data/models/models.dart';
import 'package:chat_app/shared_component/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialMainCubit, SocialMainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition:
                BlocProvider.of<SocialMainCubit>(context).posts.isNotEmpty,
            builder: (context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          Image.network(
                            "https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg",
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Communicate with friends",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildPostItem(
                            BlocProvider.of<SocialMainCubit>(context)
                                .posts[index],
                            context,
                            index);
                      },
                      itemCount: BlocProvider.of<SocialMainCubit>(context)
                          .posts
                          .length,
                    ),
                  ],
                ),
              );
            },
            fallback: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }

  Widget buildPostItem(PostModel postModel, BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      margin:
          const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    postModel.image??"",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postModel.username??"",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              fontSize: 18,
                            ),
                      ),
                      Text(
                        postModel.dateTime??"",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 22,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 10,
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                postModel.text??"",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(height: 1.3),
              ),
            ),
            if (postModel.postImage!.isNotEmpty)
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.only(top: 8.0),
                child: Image.network(
                  postModel.postImage??"",
                  fit: BoxFit.cover,
                  height: 140,
                  width: double.infinity,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      BlocProvider.of<SocialMainCubit>(context).likes[index].toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "0 comments",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              height: 15,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage(
                        BlocProvider.of<SocialMainCubit>(context)
                            .userModel == null?"":BlocProvider.of<SocialMainCubit>(context)
                            .userModel!.image??"",
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Write a comment ...",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey[600],
                          ),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<SocialMainCubit>(context).likePost(
                            BlocProvider.of<SocialMainCubit>(context)
                                .postId[index]);
                      },
                      icon: const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
