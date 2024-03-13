import 'package:cloud_firestore/cloud_firestore.dart';

class Attribution {
  final String html;

  Attribution({required this.html});

  factory Attribution.fromSnapshot(DocumentSnapshot snapshot) {
    return Attribution(
      html: snapshot['html'],
    );
  }
}
