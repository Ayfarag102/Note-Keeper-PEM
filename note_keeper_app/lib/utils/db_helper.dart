import 'package:flutter/material.dart';
import "package:sqflite/sqflite.dart";
import "package:sqflite/sqlite_api.dart";
import 'dart:async';
import "dart:io";
//import "package:path_provider/path_provider.dart";
import "package:path/path.dart";
import "./../models/Note.dart";

class DBHelper {
  static DBHelper _dbHelper;
  static Database _db;
  static final _dbName = "notes.db";
  static final _dbVersion = 1;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colReaction = 'reaction';
  String colDate = 'date';

  DBHelper._createInstance();
  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> database() async {
    if (_db != null) {
      return _db;
    }

    _db = await initiateDB();
    return _db;
  }

  Future<Database> initiateDB() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);

    final database =
        await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    debugPrint(database.toString());
    return database;
  }

  Future _onCreate(Database db, int v) async {
    await db.execute(
      '''CREATE TABLE $noteTable($colId INTEGER NOT NULL, $colTitle TEXT,$colDescription TEXT, $colPriority INTEGER, $colReaction INTEGER, $colDate TEXT, PRIMARY KEY($colId AUTOINCREMENT))''',
    );

    debugPrint("SQLITE: $noteTable CREATED at app launch");
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    // var result = await db.execute('''
    // SELECT * FROM $noteTable
    // ORDER BY $colPriority ASC
    // ''');

    var result = await _db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = <Note>[];

    for (var i = 0; i < count; i++) {
      noteList.add(Note.fromMap(noteMapList[i]));
    }
    return noteList;
  }

  Future<int> insertNote(Note note) async {
    var result = await _db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    var result = await _db.update(noteTable, note.toMap(),
        where: '$colId=?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var result =
        await _db.delete(noteTable, where: '$colId=?', whereArgs: [id]);
    return result;
  }

  Future<int> getCount() async {
    List<Map<String, dynamic>> x =
        await _db.rawQuery('SELECT COUNT(*) FROM $noteTable');

    var result = Sqflite.firstIntValue(x);
    return result;
  }
}
