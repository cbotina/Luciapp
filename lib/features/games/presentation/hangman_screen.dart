import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/games/domain/enums/game_mode.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';
import 'package:luciapp/features/games/domain/models/hangman_level.dart';

class HangmanScreen extends ConsumerStatefulWidget {
  final List<GameLevel> levels;
  final GameMode mode;

  const HangmanScreen({
    super.key,
    required this.levels,
    required this.mode,
  });

  @override
  ConsumerState<HangmanScreen> createState() => _HangmanScreenState();
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

class _HangmanScreenState extends ConsumerState<HangmanScreen> {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.appBarBackground,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          'El Ahorcado',
          style: TextStyle(
            color: Colors.white,
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
                child: Text(
                  "💡 Pista: ${level.hint}",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: colors.progressBar,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Visibility(
                      visible: errors >= 0,
                      child: Image.asset(
                        'assets/images/hangman/hang.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 1,
                      child: Image.asset(
                        'assets/images/hangman/head.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 2,
                      child: Image.asset(
                        'assets/images/hangman/body.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 3,
                      child: Image.asset(
                        'assets/images/hangman/ra.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 4,
                      child: Image.asset(
                        'assets/images/hangman/la.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 5,
                      child: Image.asset(
                        'assets/images/hangman/rl.png',
                        width: MediaQuery.of(context).size.width / 1.8,
                      ),
                    ),
                    Visibility(
                      visible: errors >= 6,
                      child: Image.asset(
                        'assets/images/hangman/ll.png',
                        width: MediaQuery.of(context).size.width / 1.8,
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
                    color: colors.appBarBackground!.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 15),
                height: 80,
                width: MediaQuery.of(context).size.width - 30,
                child: Semantics(
                  slider: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: alphabet.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
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
        setState(() {
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
              Navigator.of(context).pop();
              // ! Game completed Screen
            } else {
              level = widget.levels[levelIndex] as HangmanLevel;
            }
          }
        });
      },
      btnOkIcon: Icons.check_circle,
      btnOkText: 'Si',
      buttonsTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: const TextStyle(fontSize: 20),
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnCancelText: 'No',
      btnCancelIcon: Icons.cancel,
      btnCancelColor: Colors.pink.shade400,
    ).show();
  }

  showFailureDialog() {
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
      buttonsTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: const TextStyle(fontSize: 20),
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
    final selectedColor = ref.watch(courseColorsControllerProvider).shadow;
    return Semantics(
      label: "${letter.toLowerCase()}!",
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : selectedColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Center(
          child: ExcludeSemantics(
            child: Text(
              letter.toUpperCase(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.grey.shade300 : Colors.white,
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
    final visibleColor = ref.watch(courseColorsControllerProvider).shadow;
    final invisibleColor =
        ref.watch(courseColorsControllerProvider).appBarBackground;

    return Container(
      decoration: BoxDecoration(
        color: isVisible
            ? visibleColor.withAlpha(255)
            : invisibleColor!.withOpacity(.5),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: 30,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Center(
        child: Visibility(
          visible: isVisible,
          child: Text(
            letter.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
