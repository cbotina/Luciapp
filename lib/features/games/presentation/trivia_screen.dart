import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/courses/presentation/controllers/course_colors_controller.dart';
import 'package:luciapp/features/games/data/providers/game_levels_provider.dart';
import 'package:luciapp/features/games/domain/enums/game_mode.dart';
import 'package:luciapp/features/games/domain/models/game_level.dart';
import 'package:luciapp/features/games/domain/models/trivia_level.dart';

class TriviaPage extends ConsumerWidget {
  final String gameId;
  const TriviaPage({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(triviaLevelsProvider);
    final levels = ref.read(triviaLevelsProvider(gameId));
    return levels.when(
      data: (data) {
        return TriviaGame(levels: data, mode: GameMode.custom);
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const LinearProgressIndicator(),
    );
  }
}

class TriviaGame extends ConsumerStatefulWidget {
  final List<GameLevel> levels;
  final GameMode mode;

  const TriviaGame({super.key, required this.levels, required this.mode});

  @override
  ConsumerState<TriviaGame> createState() => _TrueOrFalseGameState();
}

class _TrueOrFalseGameState extends ConsumerState<TriviaGame> {
  late int _levelIndex;
  late TriviaLevel _level;
  late AudioPlayer _player;
  late ConfettiController _confettiController;

  late int _hits;

  final _random = Random();

  @override
  void initState() {
    if (widget.levels.isNotEmpty) {
      switch (widget.mode) {
        case GameMode.custom:
          _levelIndex = 0;
          _hits = 0;
          _level = widget.levels[_levelIndex] as TriviaLevel;
        case GameMode.random:
          _level = widget.levels[_random.nextInt(widget.levels.length)]
              as TriviaLevel;
      }
    } else {
      Navigator.of(context).pop();
    }
    _confettiController = ConfettiController();
    _player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(courseColorsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        backgroundColor: colors.appBarBackground,
        centerTitle: true,
        title: Text(
          "Verdadero o Falso",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: colors.appBarForeground,
              overflow: TextOverflow.ellipsis),
        ),
        foregroundColor: Colors.white,
      ),
      backgroundColor: colors.backgroundColor,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Semantics(
                  sortKey: const OrdinalSortKey(0),
                  focused: true,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.main,
                        ),
                        child: const Icon(
                          Icons.question_mark,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Pregunta ${widget.mode == GameMode.custom ? '${_levelIndex + 1} de ${widget.levels.length}' : ''}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _level.question,
                  // style: const TextStyle(fontSize: 17, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 10,
                ),
                ExcludeSemantics(
                  child: Image.network(
                    _level.imagePath,
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                )
              ],
            ),
          ),
          Material(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (_level.answer == false) {
                      await _player.play(
                        AssetSource('audio/success.mp3'),
                      );
                      setState(() {
                        _hits++;
                      });
                      showSuccessDialog();
                    } else {
                      await _player.play(
                        AssetSource('audio/fail.mp3'),
                      );
                      setState(() {});
                      showFailureDialog();
                    }
                  },
                  splashColor: Colors.pinkAccent.shade100,
                  highlightColor: Colors.pinkAccent.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  child: Semantics(
                    label: "Falso",
                    child: Ink(
                      height: MediaQuery.of(context).size.height * .25,
                      width: (MediaQuery.of(context).size.width / 2) - 15,
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: ExcludeSemantics(
                          child: Text(
                            "F",
                            style: TextStyle(
                              fontSize: 70,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (_level.answer == true) {
                      await _player.play(
                        AssetSource('audio/success.mp3'),
                      );
                      setState(() {
                        _hits++;
                      });
                      showSuccessDialog();
                    } else {
                      await _player.play(
                        AssetSource('audio/fail.mp3'),
                      );
                      setState(() {});
                      showFailureDialog();
                    }
                  },
                  splashColor: Colors.blue.shade300,
                  highlightColor: Colors.blue.shade300,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Semantics(
                    label: "Verdadero",
                    child: Ink(
                      height: MediaQuery.of(context).size.height * .25,
                      width: (MediaQuery.of(context).size.width / 2) - 15,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: ExcludeSemantics(
                          child: Text(
                            "V",
                            style: TextStyle(
                              fontSize: 70,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  setNextLevel() {
    setState(() {
      if (widget.mode == GameMode.random) {
        _level = widget.levels[_random.nextInt(
          widget.levels.length,
        )] as TriviaLevel;
      } else {
        _levelIndex++;
        if (_levelIndex >= widget.levels.length) {
          showScoreDialog();
        } else {
          _level = widget.levels[_levelIndex] as TriviaLevel;
        }
      }
    });
  }

  showScoreDialog() {
    if (_hits == widget.levels.length) {
      _confettiController.play();
    }
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      showCloseIcon: false,
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
      btnOkText: 'Continuar',
      buttonsTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      btnOkColor: Colors.blue,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Column(
        children: [
          Confetti(confettiController: _confettiController, widget: widget),
          const Text(
            'Bien hecho!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Has acertado $_hits preguntas de ${widget.levels.length}',
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ).show();
  }

  showSuccessDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.topSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: '¡Muy Bien!',
      desc: _level.explaination,
      btnOkOnPress: () {
        setNextLevel();
      },
      btnOkText: 'Siguiente',
      buttonsTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: const TextStyle(fontSize: 15),
      btnOkColor: Colors.blue,
      closeIcon: Container(),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      // btnCancelOnPress: () {
      //   Navigator.of(context).pop();
      // },
      // btnCancelText: 'No',
      // btnCancelIcon: Icons.cancel,
      // btnCancelColor: Colors.pink.shade400,
    ).show();
  }

  showFailureDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      showCloseIcon: true,
      title: '¡Ups!',
      desc: 'Esa respuesta no es correcta',
      btnOkOnPress: () {
        setState(() {
          setNextLevel();
        });
      },
      btnOkText: 'Siguiente',
      buttonsTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: const TextStyle(fontSize: 20),
      btnOkColor: Colors.blue,
      closeIcon: Container(),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,

      // btnCancelOnPress: () {
      //   Navigator.of(context).pop();
      // },
      // btnCancelText: 'No',
      // btnCancelIcon: Icons.cancel,
      // btnCancelColor: Colors.pink.shade400,
    ).show();
  }
}

class Confetti extends ConsumerWidget {
  const Confetti({
    super.key,
    required ConfettiController confettiController,
    required this.widget,
  }) : _confettiController = confettiController;

  final ConfettiController _confettiController;
  final TriviaGame widget;

  @override
  Widget build(BuildContext context, ref) {
    final mainColor = ref.read(courseColorsControllerProvider).main;
    final shadowColor = ref.read(courseColorsControllerProvider).shadow;
    final accentColor = ref.read(courseColorsControllerProvider).accent;
    return ConfettiWidget(
      confettiController: _confettiController,
      shouldLoop: true,
      blastDirectionality: BlastDirectionality.explosive,
      numberOfParticles: 30,
      colors: [mainColor, shadowColor, accentColor],
    );
  }
}
