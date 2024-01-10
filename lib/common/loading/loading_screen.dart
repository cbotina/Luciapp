import 'dart:async';
import 'package:flutter/material.dart';
import 'package:luciapp/common/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = 'Cargando...',
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final OverlayState state = Overlay.of(context);

    final textStreamController = StreamController<String>();
    textStreamController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
            color: Colors.black.withAlpha(150),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: size.width * .8,
                  maxHeight: size.height * .8,
                  minWidth: size.width * .5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder(
                          stream: textStreamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.requireData,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );

    state.insert(overlay);
    return LoadingScreenController(close: () {
      textStreamController.close();
      overlay.remove();
      return true;
    }, update: (text) {
      textStreamController.add(text);
      return true;
    });
  }
}
