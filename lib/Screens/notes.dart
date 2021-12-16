import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  void connection() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'notes_database.db'),
      // When the database is first created, create a table to store dogs.

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    final db = await database;
    var dbpath = join(await getDatabasesPath(), 'notes_database.db');
    bool exists = await databaseExists(dbpath);
    var data = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: ['table']);
    print(data);
    if (data == []) {
      await db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT, userId TEXT, podcast TEXT)',
      );
      await db.insert('notes', {
        "id": 1,
        "title": "Test Title",
        'body': "test body",
        'userId': '1',
        "podcast": "string theory"
      });

      var data = await db.query('notes');
      print(data);
    } else {
      await db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT, userId TEXT, podcast TEXT)',
      );
      await db.insert('notes', {
        "id": 1,
        "title": "Test Title",
        'body': "test body",
        'userId': '1',
        "podcast": "string theory"
      });
      var data = await db.query('notes');
      print(data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Notes",
                    style: textStyle,
                  )
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
          ),
        ));
  }
}
