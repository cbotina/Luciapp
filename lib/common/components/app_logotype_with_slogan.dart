import 'package:flutter/material.dart';

class ImagotypeWithSlogan extends StatelessWidget {
  final double heigth;
  const ImagotypeWithSlogan({
    required this.heigth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/imagotype_slogan_light.png',
      height: heigth,
      fit: BoxFit.fitHeight,
    );
  }
}
