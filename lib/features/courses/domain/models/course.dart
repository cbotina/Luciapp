// ignore: unused_import
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luciapp/features/courses/presentation/widgets/colors/course_colors.dart';

class Course {
  String id;
  String name;
  String description;
  String imagePath;
  int nContents;
  CloudCourseColors colors;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.colors,
    required this.nContents,
  });

  Course.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        name = snapshot.data()['name'],
        description = snapshot.data()['description'],
        imagePath = snapshot.data()['imagePath'],
        nContents = snapshot.data()['nContents'],
        colors = CloudCourseColors(
          mainColor: Color(
              int.parse(snapshot.data()['mainColor'].replaceAll('#', '0xff'))),
          shadowColor: Color(int.parse(
              snapshot.data()['shadowColor'].replaceAll('#', '0xff'))),
          highlightColor: Color(int.parse(
              snapshot.data()['highlightColor'].replaceAll('#', '0xff'))),
        );
}
