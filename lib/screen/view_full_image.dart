import 'package:flutter/material.dart';

class ImageSeen extends StatefulWidget {
  const ImageSeen({Key? key,required this.imgUrl}) : super(key: key);
  final String imgUrl;
  @override
  State<ImageSeen> createState() => _ImageSeenState();
}

class _ImageSeenState extends State<ImageSeen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Image.network(
        widget.imgUrl,
        fit: BoxFit.fill,
        height: size.height,
        width: size.width,
      ),
    );
  }
}