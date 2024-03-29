import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/constants/strings.dart';
import 'package:luciapp/features/attributions/data/providers/attributions_provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .1326,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
          final attributions = ref.watch(attributionsProvider);

          return attributions.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Strings.about,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    const Text(Strings.aboutText),
                    const SizedBox(height: 15),
                    const Text(Strings.attributions),
                    const SizedBox(height: 15),
                    ...data.map(
                      (e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: HtmlWidget(e.html),
                        );
                      },
                    )
                  ],
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
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
