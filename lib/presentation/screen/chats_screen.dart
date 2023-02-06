import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:chat_app/data/models/models.dart';
import 'package:chat_app/presentation/screen/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<SocialMainCubit, SocialMainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildChatItem(
                  BlocProvider.of<SocialMainCubit>(context).allUsers[index],
                  context);
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(right: 12, left: 12),
                child: Divider(
                  height: 5,
                  thickness: 1.5,
                ),
              );
            },
            itemCount:
                BlocProvider.of<SocialMainCubit>(context).allUsers.length,
          );
        },
      );
    });
  }

  Widget buildChatItem(UserModel user, context) {
    return InkWell(
      onTap: () {
        //print("Frooooom Inkwell ${user.uid!}");
        BlocProvider.of<SocialMainCubit>(context).getMessages(user.uid!);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => SocialMainCubit(),
            child: ChatDetailsScreen(user),
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(user.image!),
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              user.username!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, height: 1.3, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
