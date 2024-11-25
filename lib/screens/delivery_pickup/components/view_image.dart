import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  final String? image;
  ViewImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      appBar: MyAppBar(
        title: 'Recipt',
      ),
      body: Center(
        child: Hero(
          tag: 'reciept',
          child: Image.file(File(image.toString())),
        ),
      ),
    );
  }
}


class ViewNetworkImage extends StatelessWidget {
  final String? image;
  const ViewNetworkImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      appBar: MyAppBar(
        iconColor: ColorManager.whiteColor,
        backgroundColor: ColorManager.blackColor,
        title: '',
      ),
      body: Center(
          child: Hero(
        tag: image ?? '',
        child: image == null
            ? const Placeholder()
            : PhotoView(imageProvider: NetworkImage(image.toString())),
      )),
    );
  }
}
