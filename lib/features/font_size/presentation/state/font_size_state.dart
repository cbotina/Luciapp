import 'package:flutter/foundation.dart' show immutable;
import 'package:luciapp/features/font_size/domain/models/user_font_settings.dart';

@immutable
class FontSizeState {
  final double scaleFactor;
  final bool canIncreaseSize;
  final bool canDecreaseSize;

  const FontSizeState({
    required this.scaleFactor,
    required this.canIncreaseSize,
    required this.canDecreaseSize,
  });

  const FontSizeState.initial()
      : scaleFactor = 1.0,
        canIncreaseSize = true,
        canDecreaseSize = false;

  FontSizeState.fromUserFontSettings(UserFontSettings fontSettings)
      : scaleFactor = fontSettings.scaleFactor,
        canDecreaseSize = fontSettings.scaleFactor > .8,
        canIncreaseSize = fontSettings.scaleFactor < 2;

  const FontSizeState.fromScaleFactor(this.scaleFactor)
      : canDecreaseSize = scaleFactor > .8,
        canIncreaseSize = scaleFactor < 2;

  FontSizeState copyWithScaleFactor(double scaleFactor) => FontSizeState(
        scaleFactor: scaleFactor,
        canDecreaseSize: scaleFactor > .8,
        canIncreaseSize: scaleFactor < 2,
      );

  FontSizeState copyWithCanIncreaseSize(bool canIncreaseSize) => FontSizeState(
        scaleFactor: scaleFactor,
        canIncreaseSize: canIncreaseSize,
        canDecreaseSize: canDecreaseSize,
      );

  FontSizeState copyWithCanDecreaseSize(bool canDecreaseSize) => FontSizeState(
        scaleFactor: scaleFactor,
        canIncreaseSize: canIncreaseSize,
        canDecreaseSize: canDecreaseSize,
      );

  @override
  bool operator ==(Object other) =>
      other is FontSizeState &&
      scaleFactor == other.scaleFactor &&
      canIncreaseSize == other.canIncreaseSize &&
      canDecreaseSize == other.canDecreaseSize;

  @override
  int get hashCode => Object.hash(
        scaleFactor,
        canIncreaseSize,
        canDecreaseSize,
      );
}
