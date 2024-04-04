enum GameMode { custom, random }

extension StringToGameMode on String {
  GameMode toGameMode() {
    if (this == 'custom') return GameMode.custom;
    if (this == 'random') return GameMode.random;

    return GameMode.random;
  }
}
