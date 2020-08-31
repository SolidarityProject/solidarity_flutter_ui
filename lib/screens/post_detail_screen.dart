import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class PostDetailScreen extends StatefulWidget {
  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Detail",
          style: Styles.BLACK_TEXT,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(post.title),
      ),
    );
  }
}
