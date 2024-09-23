import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/resources/sized_box.dart';
import 'package:laundryday/widgets/my_loader.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final BoxFit? fit;
  CustomCacheNetworkImage(
      {super.key, required this.imageUrl, required this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      fadeInDuration: Duration(seconds: 1),
      placeholder: (context, url) => SizedBox(
        height: height,
        child: Loader(),
      ),
      errorWidget: (context, url, error) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                color: ColorManager.greyColor,
              ),
              10.ph,
              Text(
                'File Not Found',
                style: getRegularStyle(color: ColorManager.blackColor),
              )
            ],
          ),
        ),
        height: height,
        width: double.infinity,
      ),
    );
  }
}
