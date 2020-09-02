import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final Future<void> Function() cardOnTap;
  final Widget cardPostItemStar;

  PostCard({
    @required this.post,
    @required this.cardOnTap,
    @required this.cardPostItemStar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _cardPostInkwell(post),
          _cardPostItemsRow(),
        ],
      ),
    );
  }

  Widget _cardPostInkwell(Post currentPost) {
    return InkWell(
      child: _cardPostTouchableColumn(),
      onTap: () async {
        await cardOnTap();
      },
    );
  }

  Widget _cardPostTouchableColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardImage(),
        _cardTextColumn(),
      ],
    );
  }

  Widget _cardImage() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(post.pictureUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _cardTextColumn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // solidarity date & hour
          Text(
            _localDateFormat("tr_TR", post.dateSolidarity.toLocal()),
            style: Styles.POST_DATE,
          ),
          SizedBox(height: 8),

          // solidarity title
          Text(
            post.title,
            style: Styles.POST_TITLE,
          ),
          SizedBox(height: 8),

          // solidarity description
          Text(post.description),
        ],
      ),
    );
  }

  String _localDateFormat(String locale, DateTime date) {
    return DateFormat.yMMMMEEEEd(locale).format(date) +
        " - " +
        DateFormat.Hm(locale).format(date);
  }

  Widget _cardPostItemsRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          cardPostItemStar,
        ],
      ),
    );
  }
}
