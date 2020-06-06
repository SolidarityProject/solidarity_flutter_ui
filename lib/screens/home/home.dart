import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _appBarHideStatus = false;
  double _lastOffset = 0;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        _appBarHideStatus = false;
      } else if (_scrollController.offset < _lastOffset) {
        _appBarHideStatus = false;
      } else {
        _appBarHideStatus = true;
      }

      setState(() {
        _lastOffset = _scrollController.offset;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              _containerAppBar,
              _expandedListView,
              _tabBarItems
            ],
          )),
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_box),
      );

  Widget get _containerAppBar => AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height:
            _appBarHideStatus ? 0 : MediaQuery.of(context).size.height * .12,
        child: _appBar,
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
          Text("Home", style: titleTextStyle)
        ],
      );

  Widget get _tabBarItems => TabBar(tabs: <Widget>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.search),
        ),
        Tab(
          icon: Icon(Icons.message),
        )
      ]);

  Widget get _expandedListView => Expanded(
        child: _listView,
      );

  Widget get _listView => ListView.builder(
      controller: _scrollController,
      itemCount: 5,
      itemBuilder: (context, index) {
        return _listViewCard;
      });

  Widget get _listViewCard => Card(
        child: ListTile(
          title: _cardTitleText,
          subtitle: Wrap(
            runSpacing: 7,
            children: <Widget>[
              Text("Post Desc"),
              _cardPlaceHolder,
              _cardPostItemsRowPadding,
            ],
          ),
        ),
      );

  Widget get _cardTitleText => Text(
        "Post Title",
        style: titleTextStyle,
      );

  Widget get _cardPlaceHolder => Container(
        height: 100,
        child: Placeholder(
          color: Colors.redAccent,
        ),
      );

  Widget get _cardPostItemsRowPadding => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: _postItemsRow,
      );

  Widget get _postItemsRow =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
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
