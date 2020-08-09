import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:solidarity_flutter_ui/models/dtos/add_starred_post_dto.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/starred_post_service.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _width;

  List<Post> _postList;
  int _index;

  //TODO: scroll controller -> appbar show/hide

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _futureBuilderPostList(),
    );
  }

  Widget _futureBuilderPostList() => FutureBuilder<List<Post>>(
        future: futurePostList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _postList = snapshot.data;
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
      itemCount: _postList.length,
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
              image: NetworkImage(_postList[_index].pictureUrl),
              fit: BoxFit.cover),
        ),
      );

  Widget _cardTextsWrap() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _localDateFormat(
                "tr_TR",
                _postList[_index].dateSolidarity.toLocal(),
              ),
              style: Theme.of(context).textTheme.overline,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _postList[_index].title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _postList[_index].description,
            ),
          ],
        ),
      );

  String _localDateFormat(String locale, DateTime date) =>
      DateFormat.yMMMMEEEEd(locale).format(date) +
      " - " +
      DateFormat.Hm(locale).format(date);

  Widget _cardPostItemsRow() => Padding(
        padding: const EdgeInsets.only(bottom: 2.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _starIconSelection(),
          ],
        ),
      );

  Widget _starIconSelection() {
    var _starredStatus = false;

    var _text = Text(
      "Add to your starred posts ",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.blueGrey,
      ),
    );

    var _icon = Icon(
      Icons.star_border,
      color: Colors.blueGrey,
      size: 25,
    );

    for (var myPost in myStarredPosts) {
      if (myPost.toString() == _postList[_index].id) {
        _starredStatus = true;
        _text = Text("");
        _icon = Icon(
          Icons.star,
          color: Theme.of(context).primaryColor,
          size: 25,
        );
        break;
      }
    }
    return _starIconLabelButton(
        _iconLabel(_text, _icon), _starredStatus, _postList[_index].id);
  }

  Widget _iconLabel(Text text, Icon icon) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 3,
        children: <Widget>[
          text,
          icon,
        ],
      );

  Widget _starIconLabelButton(
          Widget childWidget, bool starredStatus, String postId) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: InkWell(
          child: childWidget,
          onTap: () async {
            if (starredStatus) {
              await deleleStarredPost(postId);
            } else {
              await addStarredPost(
                AddStarredPostDTO(postId: postId),
              );
            }
            await getStarredPostMyPosts();
            setState(() {
              myStarredPosts = SharedPrefs.getStarredPosts;
              futureStarredPostList = getStarredPostsByUserId(user.id);
            });
          },
        ),
      );
}
