import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageSeen extends StatefulWidget {
  const ImageSeen({Key? key,required this.imgUrl}) : super(key: key);
  final String imgUrl;
  @override
  State<ImageSeen> createState() => _ImageSeenState();
}

class _ImageSeenState extends State<ImageSeen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(widget.imgUrl),
      ),
    );
  }
}