import 'package:flutter/material.dart';
import 'package:image_preview/source/home.dart';

void main() => runApp(const ImagePreview());

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Preview',
      home: HomePage(),
    );
  }
}
