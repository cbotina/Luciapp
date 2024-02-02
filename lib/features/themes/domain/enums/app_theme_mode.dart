enum AppThemeMode {
  light(name: 'light'),
  dark(name: 'dark'),
  hcLight(name: 'hc_light'),
  hcDark(name: 'hc_dark');

  final String name;

  const AppThemeMode({required this.name});

  @override
  String toString() {
    return name;
  }
}
