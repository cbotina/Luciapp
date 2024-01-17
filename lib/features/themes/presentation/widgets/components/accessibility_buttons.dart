import 'package:flutter/cupertino.dart';
import 'package:luciapp/common/components/text_divider.dart';
import 'package:luciapp/features/themes/presentation/widgets/components/buttons/dark_mode_button.dart';
import 'package:luciapp/features/themes/presentation/widgets/components/buttons/decrease_text_size_button.dart';
import 'package:luciapp/features/themes/presentation/widgets/components/buttons/high_contrast_button.dart';
import 'package:luciapp/features/themes/presentation/widgets/components/buttons/increase_text_size_button.dart';
import 'package:luciapp/features/themes/presentation/widgets/constants/strings.dart';

class AccessibilityButtons extends StatelessWidget {
  const AccessibilityButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Wrap(
            runSpacing: 15,
            children: [
              TextDivider(Strings.fontSize),
              Row(
                children: [
                  Expanded(child: DecreaseTextSizeButton()),
                  SizedBox(width: 15),
                  Expanded(child: IncreaseTextSizeButton()),
                ],
              ),
              TextDivider(Strings.colorThemes),
              Row(
                children: [
                  DarkModeButton(),
                  SizedBox(width: 15),
                  Expanded(child: HighContrastButton()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
