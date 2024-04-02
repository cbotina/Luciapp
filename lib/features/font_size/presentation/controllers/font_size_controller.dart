import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/features/font_size/application/font_size_service.dart';
import 'package:luciapp/features/font_size/presentation/state/font_size_state.dart';

class FontSizeController extends AsyncNotifier<FontSizeState> {
  late final FontSizeService _fontSizeService =
      ref.watch(fontSizeServiceProvider);

  @override
  FutureOr<FontSizeState> build() {
    log('build controller font');
    return _fontSizeService.getCurrentFontSizeState();
  }

  Future<void> refresh() async {
    log('refresh is used');
    state = await AsyncValue.guard(
        () => _fontSizeService.getCurrentFontSizeState());
  }

  Future<void> increaseFontSize() async {
    state = await AsyncValue.guard(() => _fontSizeService.increaseFontSize());
  }

  Future<void> decreaseFontSize() async {
    state = await AsyncValue.guard(() => _fontSizeService.decreaseFontSize());
  }
}

final fontSizeControllerProvider =
    AsyncNotifierProvider<FontSizeController, FontSizeState>(
  () {
    return FontSizeController();
  },
);
