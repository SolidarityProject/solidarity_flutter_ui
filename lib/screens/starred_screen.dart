import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/models/post_model.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/starred_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/shared_prefs.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';
import 'package:solidarity_flutter_ui/widgets/logo_animation.dart';
import 'package:solidarity_flutter_ui/widgets/post_card.dart';

class StarredScreen extends StatefulWidget {
  StarredScreen({Key key}) : super(key: key);

  @override
  _StarredScreenState createState() => _StarredScreenState();
}

class _StarredScreenState extends State<StarredScreen>
    with AutomaticKeepAliveClientMixin<StarredScreen> {
  List<Post> _starredPostList;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _futureBuilderPostList(),
    );
  }

  Widget _futureBuilderPostList() {
    return FutureBuilder<List<Post>>(
      future: futureStarredPostList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _starredPostList = snapshot.data;
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
    return _starredPostList.length == 0
        ? Center(
            child: Text(
              "You don't have starred post yet.",
              style: Styles.TF_HINT,
            ),
          )
        : _listView();
  }

  Widget _listView() {
    return ListView.builder(
        itemCount: _starredPostList.length,
        itemBuilder: (context, index) {
          final currentPost = _starredPostList[index];
          return PostCard(
            post: currentPost,
            cardOnTap: () => postCardOnTapStarred(currentPost.id),
            cardPostItemStar: _cardPostItemDelete(currentPost.id),
          );
        });
  }

  Future<void> postCardOnTapStarred(String currentPostId) async {
    await Navigator.pushNamed(
      context,
      Constants.ROUTE_POSTDETAIL,
      arguments: currentPostId,
    ).then((_) => setState(() {}));
  }

  Widget _cardPostItemDelete(String currentPostId) {
    return _iconLabelButton(
      _iconLabel(
        "Delete from your starred posts ",
        Icons.delete_forever,
      ),
      currentPostId,
    );
  }

  Widget _iconLabel(String text, IconData icons) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, right: 8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 3,
        children: <Widget>[
          Text(text, style: Styles.POST_STAR_DESC),
          Icon(icons, color: Colors.blueGrey, size: 25),
        ],
      ),
    );
  }

  Widget _iconLabelButton(Widget childWidget, String postId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: InkWell(
        child: childWidget,
        onTap: () {
          var alertDiaolog = AlertDialogTwoButtons(
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
            builder: (context) => alertDiaolog,
          );
        },
      ),
    );
  }

  Future<void> _deleteFromStarredPosts(String postId) async {
    await deleteStarredPost(postId);
    await getMyStarredPosts();
    setState(() {
      myStarredPosts = SharedPrefs.getStarredPosts;
      futureStarredPostList = getStarredPostsByUserId(user.id);
    });
  }
}
