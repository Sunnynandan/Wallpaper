import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WallImage extends StatefulWidget {
  final url;
  final txt;

  const WallImage({this.url, this.txt});

  @override
  State<WallImage> createState() => _WallImageState();
}

class _WallImageState extends State<WallImage> {
  @override
  Widget build(BuildContext context) {
    var maxHeight = MediaQuery.of(context).size.height;
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Image.network(
        widget.url,
        height: maxHeight * 0.45,
        width: maxWidth * 0.5,
        color: Colors.grey,
      ),
    );
  }
}
