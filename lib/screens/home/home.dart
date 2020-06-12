import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _width, _height;

  List<Post> _postList;
  int _index;

  @override
  void initState() {
    //TODO: scroll controller -> appbar show/hide
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

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
        future: getPostsByFullAddress("Ödemiş-İzmir-Türkiye"),
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
        child: Wrap(
          spacing: 10,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: <Widget>[
            Expanded(
                child: Text(
                    _postList[_index].dateSolidarity.toLocal().toString())),
            Text(
              _postList[_index].title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(_postList[_index].description),
          ],
        ),
      );

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
