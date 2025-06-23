import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static Database? _userDatabase;
  static Database? _eventDatabase;

  // Function to get or initialize the user database
  Future<Database> get userDatabase async {
    if (_userDatabase != null) return _userDatabase!;

    _userDatabase = await _initUserDatabase();
    return _userDatabase!;
  }

  // Function to get or initialize the event database
  Future<Database> get eventDatabase async {
    if (_eventDatabase != null) return _eventDatabase!;

    _eventDatabase = await _initEventDatabase();
    return _eventDatabase!;
  }

  // Function to initialize the user database
  Future<Database> _initUserDatabase() async {
    String path = join(await getDatabasesPath(), 'user_details.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE user_details (id INTEGER PRIMARY KEY, email TEXT, password TEXT, student_name TEXT, institution_name TEXT)');
    });
  }

  // Function to initialize the event database
  Future<Database> _initEventDatabase() async {
    String path = join(await getDatabasesPath(), 'events_created.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE events (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, category TEXT, date TEXT, time TEXT, location TEXT, image TEXT, tickets INTEGER, price REAL, username TEXT)');
    });
  }

  // Function to insert user details into the database
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await userDatabase;
    return await db.insert('user_details', row);
  }

  // Function to retrieve all user details from the database
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await userDatabase;
    return await db.query('user_details');
  }

  // Function to insert event details into the database
  Future<int> insertEvent(Map<String, dynamic> row) async {
    Database db = await eventDatabase;
    return await db.insert('events', row);
  }

  // Function to retrieve all events associated with a username from the database
  Future<List<Map<String, dynamic>>> getAllEventsForUser(
      String username) async {
    Database db = await eventDatabase;
    return await db
        .query('events', where: 'username = ?', whereArgs: [username]);
  }
}
