import 'package:chat_app/business_logic/cubit/social_home_cubit.dart';
import 'package:chat_app/data/models/models.dart';
import 'package:chat_app/shared_component/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen(this.user, {Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(user.image ?? ""),
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              user.username ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500, height: 1.1, fontSize: 16),
            ),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        BlocProvider.of<SocialMainCubit>(context).getMessages(user.uid!);
        return BlocConsumer<SocialMainCubit, SocialMainState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: BlocProvider.of<SocialMainCubit>(context)
                        .messages
                        .isNotEmpty,
                    fallback: (context) => Expanded(
                      child: Center(
                        child: Text(
                          "Start chat with ${user.username!}",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    builder: (context) => Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message =
                              BlocProvider.of<SocialMainCubit>(context)
                                  .messages[index];
                          if (BlocProvider.of<SocialMainCubit>(context)
                                  .userModel!
                                  .uid ==
                              message.senderId) {
                            return buildMyMessage(message);
                          } else {
                            return buildReceiverMessage(message);
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10.0,
                          );
                        },
                        itemCount: BlocProvider.of<SocialMainCubit>(context)
                            .messages
                            .length,
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textEditingController,
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
                              hintText: "type your message here..",
                              hintStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 55,
                          color: Colors.blue,
                          child: MaterialButton(
                            onPressed: () {
                              BlocProvider.of<SocialMainCubit>(context)
                                  .sendMessage(
                                      user.uid ?? "",
                                      DateTime.now().toString(),
                                      textEditingController.text);
                            },
                            child: const Icon(
                              IconBroken.Send,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget buildMyMessage(MessageModel messageModel) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[300]!.withOpacity(0.8),
          borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                15.0,
              ),
              topEnd: Radius.circular(
                15.0,
              ),
              topStart: Radius.circular(
                15.0,
              )),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Text(
          messageModel.text ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget buildReceiverMessage(MessageModel messageModel) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                15.0,
              ),
              topEnd: Radius.circular(
                15.0,
              ),
              topStart: Radius.circular(
                15.0,
              )),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Text(
          messageModel.text ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
