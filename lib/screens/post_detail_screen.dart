import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class PostDetailScreen extends StatefulWidget {
  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

Post _post;

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    _post = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMainContainer(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Post Detail",
        style: Styles.BLACK_TEXT,
      ),
    );
  }

  Container _buildMainContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: _buildMainColumn(),
      ),
    );
  }

  Widget _buildMainColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageContainer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _localDateFormat(
                  "tr_TR",
                  _post.dateSolidarity.toLocal(),
                ),
                style: Styles.POST_DATE,
              ),
              SizedBox(height: 8),
              Text(
                _post.title,
                style: Styles.POST_TITLE,
              ),
              SizedBox(height: 8),
              Text(
                _post.description,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_post.pictureUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String _localDateFormat(String locale, DateTime date) =>
      DateFormat.yMMMMEEEEd(locale).format(date) +
      " - " +
      DateFormat.Hm(locale).format(date);
}
