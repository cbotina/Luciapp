import 'package:flutter/widgets.dart';

class AppLogotype extends StatefulWidget {
  const AppLogotype({super.key});

  @override
  State<AppLogotype> createState() => _AppLogotypeState();
}

class _AppLogotypeState extends State<AppLogotype> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/imagotype_light.png',
      height: 30,
    );
  }
}
