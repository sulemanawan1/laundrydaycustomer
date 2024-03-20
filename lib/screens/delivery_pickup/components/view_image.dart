import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/widgets/my_app_bar/my_app_bar.dart';

class ViewImage extends StatelessWidget {
  final String? image;
   ViewImage({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ColorManager.blackColor,
      appBar: MyAppBar(title: 'Recipt',
    
    
    ),body:  Center(
              child: Hero(
                tag: 'reciept',
                child: Image.file(
                  File(image.toString())
                ),
              ),
            ),
          )
        ;
  }
}
