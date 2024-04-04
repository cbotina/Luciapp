enum GameType {
  hangman,
  trivia,
}

extension StringToGameType on String {
  GameType toGameType() {
    if (this == 'hangman') return GameType.hangman;
    if (this == 'trivia') return GameType.trivia;

    return GameType.hangman;
  }
}
