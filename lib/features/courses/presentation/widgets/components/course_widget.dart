// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:ribbon_widget/ribbon_widget.dart';

// Todo: Replace with tappable container

class CourseWidget extends StatelessWidget {
  const CourseWidget({
    super.key,
    this.isNew = false,
    required this.name,
    required this.description,
    required this.imageProvider,
    required this.percentageCompleted,
    required this.mainColor,
  });

  final bool isNew;
  final String name;
  final String description;
  final ImageProvider imageProvider;
  final double percentageCompleted;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Ribbon(
          nearLength: isNew ? 80 : 0,
          farLength: isNew ? 30 : 0,
          title: 'Nuevo!',
          titleStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontFamily: 'Lilita',
            fontSize: 18,
          ),
          color: Theme.of(context).colorScheme.secondary,
          location: RibbonLocation.topEnd,
          child: Ink(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              boxShadow: const [], // ! add shadows
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth - 15 - 15 - 120,
                          child: Text(
                            description,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    Image(
                      image: imageProvider,
                      width: 110,
                      height: 110,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                LinearProgressIndicator(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  color: mainColor,
                  value: percentageCompleted,
                  borderRadius: BorderRadius.circular(20),
                  minHeight: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
