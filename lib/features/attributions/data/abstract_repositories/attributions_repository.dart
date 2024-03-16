import 'package:luciapp/features/attributions/domain/models/attribution.dart';

abstract class IAttributionsRepository {
  Future<List<Attribution>> getAll();
  Future<String> getAttributionText();
}
