import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/common/components/tappable_container.dart';
import 'package:luciapp/common/constants/strings.dart';
import 'package:luciapp/common/utils/page_wrapper.dart';
import 'package:luciapp/features/attributions/data/providers/about_text_provider.dart';
import 'package:luciapp/features/attributions/data/providers/attributions_provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final attributions = ref.watch(attributionsProvider);
        final aboutText = ref.watch(aboutTextProvider);

        return attributions.when(
          data: (data) {
            return AccessibilityWrapper(
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .8,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Strings.about,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 15),
                        aboutText.when(
                          data: (text) => Text(text.replaceAll(r'\n', '\n')),
                          error: (error, stackTrace) => Text(error.toString()),
                          loading: () => const CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 15),
                        const Text(Strings.attributions),
                        const SizedBox(height: 15),
                        ...data.map(
                          (e) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: HtmlWidget(e.html),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text(error.toString()),
        );
      },
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
