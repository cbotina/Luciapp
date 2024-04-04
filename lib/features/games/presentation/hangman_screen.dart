// ignore_for_file: unused_result, use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/course_progress/presentation/controllers/complete_content_controller.dart';
import 'package:luciapp/features/courses/domain/enums/content_types.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/font_size/presentation/controllers/font_size_controller.dart';
import 'package:luciapp/features/games/data/providers/game_levels_provider.dart';
import 'package:luciapp/features/games/domain/enums/game_mode.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';
import 'package:luciapp/features/games/domain/models/hangman_level.dart';
import 'package:luciapp/features/themes/data/providers/theme_mode_provider.dart';
import 'package:luciapp/features/themes/domain/enums/app_theme_mode.dart';
import 'package:luciapp/pages/course_page.dart';

class HangmanPage extends ConsumerWidget {
  final String gameId;
  const HangmanPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levels = ref.watch(hangmanLevelsProvider(gameId));

    return levels.when(
      data: (data) {
        return HangmanGame(levels: data, mode: GameMode.custom);
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () {
        return const Center(
          child: LinearProgressIndicator(),
        );
      },
    );
  }
}

class HangmanGame extends ConsumerStatefulWidget {
  final List<GameLevel> levels;
  final GameMode mode;

  const HangmanGame({
    super.key = const ValueKey('hangmangame'),
    required this.levels,
    required this.mode,
  });

  @override
  ConsumerState<HangmanGame> createState() => _HangmanScreenState();
}

const List<String> alphabet = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'Ñ',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

class _HangmanScreenState extends ConsumerState<HangmanGame> {
  bool isHintVisible = false;
  int errors = 0;
  int hits = 0;
  List<String> selectedLetters = [];

  late HangmanLevel level;
  late AudioPlayer player;
  late int levelIndex;

  final _random = Random();

  @override
  void initState() {
    if (widget.levels.isNotEmpty) {
      if (widget.mode == GameMode.custom) {
        levelIndex = 0;
        level = widget.levels[levelIndex] as HangmanLevel;
      } else {
        level = widget.levels[_random.nextInt(widget.levels.length)]
            as HangmanLevel;
      }
    } else {
      Navigator.of(context).pop();
    }
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(courseColorsControllerProvider);
    Color? drawingColor;
    final themeMode = ref.watch(themeModeProvider);

    if (themeMode == AppThemeMode.dark) {
      drawingColor = colors.main;
    } else if (themeMode == AppThemeMode.hcDark) {
      drawingColor = colors.accent;
    } else if (themeMode == AppThemeMode.hcLight) {
      drawingColor = Colors.black;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: colors.appBarIcons,
        ),
        backgroundColor: colors.appBarBackground,
        centerTitle: true,
        foregroundColor: colors.appBarForeground,
        title: const Text(
          'El Ahorcado',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: colors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Semantics(
                  label: "Pista: ${level.hint}",
                  child: Text(
                    "💡 Pista: ${level.hint}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: colors.appBarBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Visibility(
                      visible: errors >= 0,
                      child: Image.asset(
                        'assets/images/hangman/hang.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                        color: drawingColor,
                      ),
                    ),
                    Visibility(
                      key: const ValueKey('hangman-head'),
                      visible: errors >= 1,
                      child: Image.asset(
                        'assets/images/hangman/head.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                        color: drawingColor,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 2,
                      child: Image.asset(
                        'assets/images/hangman/body.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                        color: drawingColor,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 3,
                      child: Image.asset(
                        'assets/images/hangman/ra.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                        color: drawingColor,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 4,
                      child: Image.asset(
                        'assets/images/hangman/la.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                        color: drawingColor,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 5,
                      child: Image.asset(
                        'assets/images/hangman/rl.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                        color: drawingColor,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 6,
                      key: const ValueKey('hangman-ll'),
                      child: Image.asset(
                        'assets/images/hangman/ll.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                        color: drawingColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: level.word.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return LetterField(
                      letter: level.word[index],
                      isVisible: selectedLetters
                          .contains(level.word[index].toUpperCase()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Selecciona una letra de la siguiente lista',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.backgroundColor != null
                        ? colors.shadow.withOpacity(.5)
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 15),
                height: 80,
                width: MediaQuery.of(context).size.width - 30,
                child: Semantics(
                  key: const ValueKey('letter-list'),
                  slider: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: alphabet.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        key:
                            ValueKey('letter-${alphabet[index].toLowerCase()}'),
                        onTap: () async {
                          HapticFeedback.selectionClick();
                          if (selectedLetters.contains(alphabet[index])) {
                            return;
                          }
                          setState(() {
                            selectedLetters.add(
                              alphabet[index],
                            );
                            if (!level.word
                                .toUpperCase()
                                .split('')
                                .contains(alphabet[index])) {
                              errors++;
                              SemanticsService.announce(
                                'Incorrecto',
                                TextDirection.ltr,
                                assertiveness: Assertiveness.assertive,
                              );
                            } else {
                              int matches = countMatchingLetters(
                                level.word.toUpperCase(),
                                alphabet[index],
                              );
                              SemanticsService.announce(
                                'Correcto',
                                TextDirection.ltr,
                                assertiveness: Assertiveness.assertive,
                              );
                              hits = hits + matches;
                            }
                          });

                          await sayWord();

                          if (level.word.length == hits) {
                            await player.play(
                              AssetSource('audio/success.mp3'),
                            );
                            showSuccessDialog();
                          }
                          if (errors == 6) {
                            await player.play(
                              AssetSource('audio/fail.mp3'),
                            );
                            showFailureDialog();
                          }
                        },
                        child: Ink(
                          child: AlphabetLetterField(
                            letter: alphabet[index],
                            isSelected:
                                selectedLetters.contains(alphabet[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sayWord() async {
    List<String> letters = level.word.toUpperCase().split('');

    String palabra = '';
    for (String letter in letters) {
      if (selectedLetters.contains(letter)) {
        palabra = "$palabra.$letter.";
        SemanticsService.announce(
            'Te quedan ${6 - errors} intentos', TextDirection.ltr);
      } else {
        palabra = '$palabra Espacio ';
      }
    }
    if (level.word.length == hits) palabra = level.word;
    SemanticsService.announce(
      'La palabra es: $palabra',
      TextDirection.ltr,
      assertiveness: Assertiveness.assertive,
    );
  }

  showSuccessDialog() {
    final scaleFactor =
        ref.watch(fontSizeControllerProvider).value?.scaleFactor ?? 1.0;

    const bodySize = 15;
    const titleSize = 20;
    const buttonTextSize = 18;

    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: false,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: '¡Muy Bien!',
      desc: widget.mode == GameMode.random
          ? '¿Seguir Jugando?'
          : 'Siguiente Nivel',
      btnOkOnPress: () {
        setState(() async {
          hits = 0;
          errors = 0;
          isHintVisible = false;
          selectedLetters = [];
          if (widget.mode == GameMode.random) {
            level = widget.levels[_random.nextInt(
              widget.levels.length,
            )] as HangmanLevel;
          } else {
            levelIndex++;
            if (levelIndex >= widget.levels.length) {
              await ref
                  .read(completeContentControllerProvider.notifier)
                  .completeContent();

              await player.play(
                AssetSource('audio/contentfinish.mp3'),
              );

              ref.refresh(completedContentProvider);
              ref
                  .read(completedContentProvider.notifier)
                  .setCompletedContentType(ContentTypes.video);

              const Duration(milliseconds: 500);
              Navigator.of(context).pop();
            } else {
              setState(() {
                level = widget.levels[levelIndex] as HangmanLevel;
              });
            }
          }
        });
      },
      btnOkIcon: Icons.check_circle,
      btnOkText: 'Si',
      buttonsTextStyle: TextStyle(
        fontSize: buttonTextSize * scaleFactor,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        fontSize: titleSize * scaleFactor,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: TextStyle(fontSize: bodySize * scaleFactor),
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnCancelText: 'No',
      btnCancelIcon: Icons.cancel,
      btnCancelColor: Colors.pink.shade400,
    ).show();
  }

  showFailureDialog() {
    final scaleFactor =
        ref.watch(fontSizeControllerProvider).value?.scaleFactor ?? 1.0;

    const bodySize = 15;
    const titleSize = 20;
    const buttonTextSize = 18;

    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: false,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: '¡Oh no, se acabaron los intentos!',
      desc: '¿Seguir Jugando?',
      btnOkOnPress: () {
        // handle depending on gamemode
        setState(() {
          hits = 0;
          errors = 0;
          isHintVisible = false;
          selectedLetters = [];
          level = widget.levels[_random.nextInt(
            widget.levels.length,
          )] as HangmanLevel;
        });
      },
      btnOkIcon: Icons.check_circle,
      btnOkText: 'Si',
      buttonsTextStyle: TextStyle(
        fontSize: buttonTextSize * scaleFactor,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        fontSize: titleSize * scaleFactor,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: TextStyle(fontSize: bodySize * scaleFactor),
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnCancelText: 'No',
      btnCancelIcon: Icons.cancel,
      btnCancelColor: Colors.pink.shade400,
    ).show();
  }

  // letterField(String letter, bool isVisible) => const LetterField();

  // alphabetLetterField(String letter, bool isSelected) =>
  //     AlphabetLetterField(widget: widget);
}

class AlphabetLetterField extends ConsumerWidget {
  final String letter;
  final bool isSelected;
  const AlphabetLetterField({
    super.key,
    required this.letter,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, ref) {
    final colors = ref.watch(courseColorsControllerProvider);
    return Semantics(
      label: "${letter.toLowerCase()}!",
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : colors.letterBagkround,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colors.borders ?? Colors.transparent,
            width: 4,
          ),
        ),
        width: 60,
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Center(
          child: ExcludeSemantics(
            child: Text(
              letter.toUpperCase(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color:
                    isSelected ? Colors.grey.shade300 : colors.letterForeground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LetterField extends ConsumerWidget {
  final bool isVisible;
  final String letter;

  const LetterField({
    super.key,
    required this.isVisible,
    required this.letter,
  });

  @override
  Widget build(BuildContext context, ref) {
    final colors = ref.watch(courseColorsControllerProvider);

    return Container(
      decoration: BoxDecoration(
        color: isVisible
            ? colors.letterBagkround
            : colors.letterDisabledBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colors.borders ?? Colors.transparent,
          width: 4,
        ),
      ),
      height: 60,
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Center(
        child: Visibility(
          visible: isVisible,
          child: Text(
            letter.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.letterForeground,
            ),
          ),
        ),
      ),
    );
  }
}

int countMatchingLetters(String text, String path) {
  int matches = 0;
  for (String c in text.split('')) {
    if (c == path) {
      matches++;
    }
  }
  return matches;
}
