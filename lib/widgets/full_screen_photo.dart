import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> pictureArg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: GestureDetector(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Hero(
            tag: pictureArg[0],
            child: PhotoView(
              backgroundDecoration: BoxDecoration(
                color: Colors.white70,
              ),
              imageProvider: NetworkImage(pictureArg[1]),
            ),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
