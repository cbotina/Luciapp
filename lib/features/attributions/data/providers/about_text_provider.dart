import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:luciapp/main.dart';

final aboutTextProvider = FutureProvider<String>((ref) async {
  return ref.watch(attributionsRepositoryProvider).getAttributionText();
});
