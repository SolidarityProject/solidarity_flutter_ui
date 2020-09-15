import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:solidarity_flutter_ui/models/dtos/add_starred_post_dto.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/starred_post_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/logo_animation.dart';
import 'package:solidarity_flutter_ui/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  ThemeData _themeData;

  List<Post> _postList;

  //TODO: scroll controller -> appbar show/hide

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    initializeDateFormatting();

    _themeData = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _addressInfoText(),
          Expanded(child: _futureBuilderPostList()),
        ],
      ),
    );
  }

  Widget _addressInfoText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, right: 25),
      child: Text(
        "${searchAddress.district} / ${searchAddress.province.toUpperCase()}",
        style: Styles.POST_DATE,
      ),
    );
  }

  Widget _futureBuilderPostList() {
    return FutureBuilder<List<Post>>(
      future: futurePostList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _postList = snapshot.data;
          return _postWidgetSelection();
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return LogoAnimation();
        }
      },
    );
  }

  Widget _postWidgetSelection() {
    return _postList.length == 0
        ? Center(
            child: Text(
              "There is no solidarity post in ${searchAddress.district} / ${searchAddress.province.toUpperCase()} yet.",
              style: Styles.TF_HINT,
            ),
          )
        : _listView();
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _postList.length,
      itemBuilder: (context, index) {
        final currentPost = _postList[index];
        return PostCard(
          post: currentPost,
          cardOnTap: () => postCardOnTapHome(currentPost.id),
          cardPostItemStar: _starIconSelection(currentPost.id),
        );
      },
    );
  }

  Future<void> postCardOnTapHome(String currentPostId) async {
    await Navigator.pushNamed(
      context,
      Constants.ROUTE_POSTDETAIL,
      arguments: currentPostId,
    ).then((_) => setState(() {}));
  }

  Widget _starIconSelection(String currentPostId) {
    var _starredStatus = false;

    var _text = Text(
      "Add to your starred posts ",
      style: Styles.POST_STAR_DESC,
    );

    var _icon = Icon(
      Icons.star_border,
      color: Colors.blueGrey,
      size: 25,
    );

    for (var myPost in myStarredPosts) {
      if (myPost.toString() == currentPostId) {
        _starredStatus = true;
        _text = Text("");
        _icon = Icon(
          Icons.star,
          color: _themeData.primaryColor,
          size: 25,
        );
        break;
      }
    }

    return _starIconLabelButton(
      _iconLabel(_text, _icon),
      _starredStatus,
      currentPostId,
    );
  }

  Widget _iconLabel(Text textWidget, Icon iconWidget) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 3,
      children: <Widget>[
        textWidget,
        iconWidget,
      ],
    );
  }

  Widget _starIconLabelButton(
    Widget childWidget,
    bool starredStatus,
    String postId,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: InkWell(
        child: childWidget,
        onTap: () async {
          if (starredStatus) {
            await deleteStarredPost(postId);
          } else {
            await addStarredPost(
              AddStarredPostDTO(postId: postId),
            );
          }
          await getMyStarredPosts();
          setState(() {
            myStarredPosts = SharedPrefs.getStarredPosts;
            futureStarredPostList = getStarredPostsByUserId(user.id);
          });
        },
      ),
    );
  }
}
