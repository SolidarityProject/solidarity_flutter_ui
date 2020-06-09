import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Post>> _futurePosts;
  List<Post> _postList;

  @override
  void initState() {
    //TODO: scroll controller -> appbar show/hide
    super.initState();
    _futurePosts = getPostsByFullAddress("Ödemiş-İzmir-Türkiye");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      appBar: _appBar,
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[_expandedListView, _tabBarItems],
          )),
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_box),
      );

  Widget get _appBar => AppBar(
        elevation: 0,
        title: _appBarItems,
      );

  Widget get _appBarItems => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        children: <Widget>[
          CircleAvatar(
            child: Text("MC"),
          ),
          Text("Solidarity Platform", style: titleTextStyle)
        ],
      );

  Widget get _tabBarItems => TabBar(tabs: <Widget>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.search),
        ),
      ]);

  Widget get _expandedListView => Expanded(
        child: _futureBuilderPostList,
      );

  Widget get _futureBuilderPostList => FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _postList = snapshot.data;
            return _listView;
          } else if (snapshot.error) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      );

  Widget get _listView => ListView.builder(
      itemCount: _postList.length,
      itemBuilder: (context, index) {
        return _listViewCardPadding(index);
      });

  Widget _listViewCardPadding(int index) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: _listViewCard(index),
      );

  Widget _listViewCard(int index) => Card(
        child: ListTile(
          title: _cardImage,
          subtitle: Wrap(
            runSpacing: 7,
            children: <Widget>[
              _cardTextsColoumn(index),
              _cardPostItemsRow,
            ],
          ),
        ),
      );

  Widget get _cardImage => Container(
        height: 200,
        child: Image(
          image: NetworkImage("http://192.168.42.94/iisstart.png"),
        ),
      );

  Widget _cardTextsColoumn(int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_postList[index].dateSolidarity.toLocal().toString()),
          Text(
            _postList[index].title,
            style: titleTextStyle.copyWith(letterSpacing: 0, fontSize: 18),
          ),
          Text(_postList[index].description),
        ],
      );

  Widget get _cardPostItemsRow =>
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        _iconLabelButton(_iconLabel("43", Icons.favorite_border)),
        _iconLabelButton(_iconLabel("", Icons.star_border)),
      ]);

  Widget _iconLabel(String text, IconData icons) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 3,
        children: <Widget>[
          Icon(
            icons,
            color: Colors.blueGrey,
          ),
          Text(text),
        ],
      );

  Widget _iconLabelButton(Widget childWidget) => InkWell(
        child: childWidget,
        onTap: () {},
      );
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black);
