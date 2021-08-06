import 'package:flutter/material.dart';
import 'package:udemy_flutter/social_app/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'Add Post', actions: []),
      body: Center(
        child: Text('New post'),
      ),
    );
  }
}
