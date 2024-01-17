import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .1326,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Juegos 🎮",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Aprende mientras te diviertes",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
      // backgroundColor: Colors.amber,
      body: const TitleContainerBorder(
        alignment: Alignment.topLeft,
      ),
    );
  }
}

class TitleContainerBorder extends StatelessWidget {
  final AlignmentGeometry alignment;
  const TitleContainerBorder({
    super.key,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: alignment,
          child: Container(
            height: MediaQuery.of(context).size.height * .05,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
        Align(
          alignment: alignment,
          child: Container(
            margin: const EdgeInsets.only(top: 2),
            height: MediaQuery.of(context).size.height * .05,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.only(
                topLeft: alignment == Alignment.topLeft
                    ? const Radius.circular(40)
                    : Radius.zero,
                topRight: alignment == Alignment.topRight
                    ? const Radius.circular(40)
                    : Radius.zero,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
