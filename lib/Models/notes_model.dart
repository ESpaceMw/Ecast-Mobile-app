import 'package:sqflite/sqflite.dart';

class Note {
  final int id;
  final String title;
  final String body;
  final String userId;
  final String podcast;

  Note({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.podcast,
  });
}
