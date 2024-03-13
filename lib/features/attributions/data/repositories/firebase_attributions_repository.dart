import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luciapp/features/attributions/data/abstract_repositories/attributions_repository.dart';
import 'package:luciapp/features/attributions/domain/models/attribution.dart';

class FirebaseAttributionsRepository implements IAttributionsRepository {
  @override
  Future<List<Attribution>> getAll() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('attributions').get();

    return snapshot.docs.map((doc) => Attribution.fromSnapshot(doc)).toList();
  }
}
