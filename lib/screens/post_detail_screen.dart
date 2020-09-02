import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solidarity_flutter_ui/models/dtos/post_detail_dto.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/post_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/logo_animation.dart';

class PostDetailScreen extends StatefulWidget {
  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Future<PostDetailDTO> _futurePostDetail;
  PostDetailDTO _postDetail;

  @override
  Widget build(BuildContext context) {
    final String postId = ModalRoute.of(context).settings.arguments;
    _futurePostDetail = getPostDetailById(postId);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _futureBuilderPostDetail(),
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

  Widget _futureBuilderPostDetail() {
    return FutureBuilder<PostDetailDTO>(
      future: _futurePostDetail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _postDetail = snapshot.data;
          return _buildMainContainer();
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return LogoAnimation();
        }
      },
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
        _buildCreatedContainer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _localDateFormat(
                  "tr_TR",
                  _postDetail.post.dateSolidarity.toLocal(),
                ),
                style: Styles.POST_DATE,
              ),
              SizedBox(height: 8),
              Text(
                _postDetail.post.title,
                style: Styles.POST_TITLE,
              ),
              SizedBox(height: 8),
              Text(
                _postDetail.post.description,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreatedContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _postDetail.createdFullName,
            style: Styles.POST_TITLE.copyWith(fontSize: 17),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundImage: NetworkImage(_postDetail.createdPictureUrl),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_postDetail.post.pictureUrl),
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