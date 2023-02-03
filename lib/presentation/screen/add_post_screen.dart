import 'package:flutter/material.dart';

import '../../shared_component/icon_broken.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Post",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(IconBroken.Arrow___Left_2),
        ),
      ),
      body: Container(),
    );
  }
}
