import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';

@immutable
class Course {
  final String _id;
  final String _name;
  final String _description;
  final String _imagePath;
  final int _nContents;
  final CloudCourseColors _colors;

  const Course(
      {required String id,
      required String name,
      required String description,
      required String imagePath,
      required int nContents,
      required CloudCourseColors colors})
      : _id = id,
        _name = name,
        _description = description,
        _imagePath = imagePath,
        _nContents = nContents,
        _colors = colors;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get imagePath => _imagePath;
  int get nContents => _nContents;
  CloudCourseColors get colors => _colors;

  Course.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this(
          id: snapshot.id,
          name: snapshot.data()['name'],
          description: snapshot.data()['description'],
          imagePath: snapshot.data()['imagePath'],
          nContents: snapshot.data()['nContents'],
          colors: CloudCourseColors(
            mainColor: Color(int.parse(
                snapshot.data()['mainColor'].replaceAll('#', '0xff'))),
            shadowColor: Color(int.parse(
                snapshot.data()['shadowColor'].replaceAll('#', '0xff'))),
            highlightColor: Color(int.parse(
                snapshot.data()['highlightColor'].replaceAll('#', '0xff'))),
          ),
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          imagePath == other.imagePath &&
          nContents == other.nContents &&
          colors == other.colors;

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        description,
        imagePath,
        nContents,
        colors,
      ]);
}
