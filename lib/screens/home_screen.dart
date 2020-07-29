import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';

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
      floatingActionButton: _fabButton(),
      body: _futureBuilderPostList(),
    );
  }

  Widget _fabButton() => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_box),
      );

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
        children: <Widget>[_cardImage(), _cardTextsWrap()],
      );

  Widget _cardImage() => Container(
        height: 180,
        width: _width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(_postList[_index].pictureUrl),
                fit: BoxFit.cover)),
      );

  Widget _cardTextsWrap() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _localDateFormat(
                  "tr_TR", _postList[_index].dateSolidarity.toLocal()),
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
            Text(_postList[_index].description),
          ],
        ),
      );

  String _localDateFormat(String locale, DateTime date) =>
      DateFormat.yMMMMEEEEd(locale).format(date) +
      " - " +
      DateFormat.Hm(locale).format(date);

  Widget _cardPostItemsRow() =>
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        _iconLabelButton(_iconLabel("43", Icons.favorite_border)),
        _iconLabelButton(_iconLabel("", Icons.share)),
        _iconLabelButton(_iconLabel("", Icons.star_border)),
      ]);

  Widget _iconLabel(String text, IconData icons) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 3,
        children: <Widget>[
          Icon(
            icons,
            color: Colors.blueGrey,
            size: 25,
          ),
          Text(text),
        ],
      );

  Widget _iconLabelButton(Widget childWidget) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: InkWell(
          child: childWidget,
          onTap: () {},
        ),
      );
}
