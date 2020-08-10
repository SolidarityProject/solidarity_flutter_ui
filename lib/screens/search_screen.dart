import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _address;
    return Container(
        child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Şehrini ara",
          ),
          onChanged: (value) {
            _address = value;
          },
        ),
      ),
      FlatButton(
        onPressed: () {
          _controller.clear();
          //futurePostList = getPostsByFullAddress(_address);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Sonuç"),
                content: new Text("Aranan Şehir : $_address"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Tamam"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Text("Ara"),
      ),
    ]));
  }
}
