import 'package:chat_app/shared_component/icon_broken.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=826&t=st=1675261907~exp=1675262507~hmac=538631e233852f81b5d178c2aca17fdc6eb433d9f5aa6e832011ed8ab767448d",
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
            itemBuilder: (context, inde) {
              return buildPostItem(context);
            },
            itemCount: 15,
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(BuildContext context) {
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
                const CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    "https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=740&t=st=1675254193~exp=1675254793~hmac=9e3d1f8f16503aaea609d22c0e66687efa45e33523d8c75e08fa99dd7e2ed64d",
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
                        "Mohammed Ali",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                      ),
                      Text(
                        "February 1,2023 at 03:00 PM",
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
            Text(
              "Lorem ipsum, or lipsum as it is , is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. ",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.3),
            ),
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.only(top: 8.0),
              child: Image.network(
                "https://img.freepik.com/free-photo/social-media-concept-with-smartphone_52683-100042.jpg?w=740&t=st=1675251935~exp=1675252535~hmac=0b02edf56811a9330fd6e7c449872d0f7fa6ee52740ffe6687e7e617c2c0e6e7",
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
                      "120",
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
                      "120 comments",
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
                    const CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=740&t=st=1675254193~exp=1675254793~hmac=9e3d1f8f16503aaea609d22c0e66687efa45e33523d8c75e08fa99dd7e2ed64d",
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
                      onPressed: () {},
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
