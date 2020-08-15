import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/starred_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

class StarredScreen extends StatefulWidget {
  StarredScreen({Key key}) : super(key: key);

  @override
  _StarredScreenState createState() => _StarredScreenState();
}

class _StarredScreenState extends State<StarredScreen> {
  double _width;

  List<Post> _starredPostList;
  int _index;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _futureBuilderPostList(),
    );
  }

  Widget _futureBuilderPostList() => FutureBuilder<List<Post>>(
        future: futureStarredPostList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _starredPostList = snapshot.data;
            return _listView();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );

  Widget _listView() => ListView.builder(
      itemCount: _starredPostList.length,
      itemBuilder: (context, index) {
        _index = index;
        return _listViewCard();
      });

  Widget _listViewCard() => Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardPostInkwell(),
            _cardPostItemsRow(),
          ],
        ),
      );

  Widget _cardPostInkwell() => InkWell(
        child: _cardPostTouchableColumn(),
        onTap: () {},
      );

  Widget _cardPostTouchableColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _cardImage(),
          _cardTextsWrap(),
        ],
      );

  Widget _cardImage() => Container(
        height: 180,
        width: _width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  _starredPostList[_index].pictureUrl,
                ),
                fit: BoxFit.cover)),
      );

  Widget _cardTextsWrap() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _localDateFormat(
                "tr_TR",
                _starredPostList[_index].dateSolidarity.toLocal(),
              ),
              style: Theme.of(context).textTheme.overline,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _starredPostList[_index].title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            Text(_starredPostList[_index].description),
          ],
        ),
      );

  String _localDateFormat(String locale, DateTime date) =>
      DateFormat.yMMMMEEEEd(locale).format(date) +
      " - " +
      DateFormat.Hm(locale).format(date);

  Widget _cardPostItemsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _iconLabelButton(
            _iconLabel(
              "Delete from your starred posts ",
              Icons.delete_forever,
            ),
            _starredPostList[_index].id,
          ),
        ],
      );

  Widget _iconLabel(String text, IconData icons) => Padding(
        padding: const EdgeInsets.only(
          bottom: 2.0,
          right: 8.0,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 3,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey,
              ),
            ),
            Icon(
              icons,
              color: Colors.blueGrey,
              size: 25,
            ),
          ],
        ),
      );

  Widget _iconLabelButton(Widget childWidget, String postId) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: InkWell(
          child: childWidget,
          onTap: () {
            var alertDiaologTwoButtons = AlertDialogTwoButtons(
              title: "Are you sure?",
              content: "This post will delete from your starred posts.",
              noText: "Cancel",
              yesText: "Delete",
              noOnPressed: () {},
              yesOnPressed: () async {
                await _deleteFromStarredPosts(postId);
              },
            );
            showDialog(
              context: context,
              builder: (context) => alertDiaologTwoButtons,
            );
          },
        ),
      );

  Future<void> _deleteFromStarredPosts(String postId) async {
    await deleteStarredPost(postId);
    await getMyStarredPosts();
    setState(() {
      myStarredPosts = SharedPrefs.getStarredPosts;
      futureStarredPostList = getStarredPostsByUserId(user.id);
    });
  }
}
