import 'package:flutter/material.dart';

import '../../../../core/utils/app_images.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          AppImages.alphabetImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
