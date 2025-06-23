import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project/database_files/database_helper.dart';
import 'package:project/student_login.dart';
import 'package:sqflite/sqflite.dart'; // Import the StudentLogin file

final dbHelper = DatabaseHelper.instance;

class SignupPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _institutionNameController =
      TextEditingController();

  Future<void> _saveUserDetailsToDatabase(String email, String password,
      String studentName, String institutionName, BuildContext context) async {
    // Get a location using path_provider
    String path = join(await getDatabasesPath(), 'user_details.db');

    // Open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // Create the user_details table
      await db.execute(
          'CREATE TABLE user_details (id INTEGER PRIMARY KEY, email TEXT, password TEXT, student_name TEXT, institution_name TEXT)');
    });

    // Check if the email already exists in the database
    List<Map<String, dynamic>> existingUsers = await database.query(
      'user_details',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingUsers.isNotEmpty) {
      // Display an error message if email already exists
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An account with this email already exists.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Insert user details into the database
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO user_details(email, password, student_name, institution_name) VALUES(?, ?, ?, ?)',
          [email, password, studentName, institutionName]);
    });

    // Close the database
    await database.close();

    // Navigate to StudentLogin after saving user details
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentLogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          title: null,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.festival,
                size: 100.0,
                color: Colors.white,
              ),
              SizedBox(height: 10.0),
              Text(
                'Student Signup',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email ID',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ),
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                // Regular expression pattern for email validation
                // This pattern checks for the basic structure of an email address
                // You can use a more comprehensive pattern for stricter validation if needed
                final RegExp emailRegex =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 30.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ),
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30.0),
            TextFormField(
              controller: _studentNameController,
              decoration: InputDecoration(
                labelText: 'Name of Student',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ),
                labelStyle: TextStyle(fontSize: 14.0),
              ),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              controller: _institutionNameController,
              decoration: InputDecoration(
                labelText: 'Name of Institution',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ),
                labelStyle: TextStyle(fontSize: 14.0),
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                // Check if all text fields are filled and email is valid
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty ||
                    _studentNameController.text.isEmpty ||
                    _institutionNameController.text.isEmpty) {
                  // Show an error dialog if any field is empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please fill in all fields.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Save user details to SQLite database
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String studentName = _studentNameController.text;
                  String institutionName = _institutionNameController.text;
                  await _saveUserDetailsToDatabase(
                      email, password, studentName, institutionName, context);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
