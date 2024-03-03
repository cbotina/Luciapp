import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/active_content_controller.dart';
import 'package:luciapp/main.dart';

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
      body: Consumer(
        builder: (context, ref, child) {
          return Center(
            child: ElevatedButton(
              onPressed: () async {
                final active = ref.watch(activeContentControllerProvider);

                print(active.courseId);
                print(active.userId);
                final progress = await ref
                    .watch(courseProgressRepositoryProvider)
                    .get(active.courseId ?? "", active.userId ?? "");
                print(progress);
              },
              child: const Text("hola"),
            ),
          );
        },
      ),
    );
  }
}

class GameWidget extends StatelessWidget {
  final String name;
  final IconData iconData;

  const GameWidget({
    super.key,
    required this.name,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TappableContainer(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, textAlign: TextAlign.center),
            Icon(iconData, size: 50),
          ],
        ),
      ),
    );
  }
}
