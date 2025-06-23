import 'package:flutter/material.dart';
import 'package:project/college_dashboard.dart'; // Import CollegeDashboard
import 'package:project/college_signup.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path; // Import path package with an alias
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(CollegeLogin());
}

class CollegeLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late Database _database; // Add late keyword here

  // Open database connection
  Future<void> _openDatabase() async {
    _database = await openDatabase(
      path.join(await getDatabasesPath(), 'collegedata.db'), // Use path.join
      version: 1,
    );
  }

  // Check if username and password match any entry in the database
  Future<bool> _checkLogin(String username, String password) async {
    await _openDatabase();
    final List<Map<String, dynamic>> result = await _database.query(
      'collegedata',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      // Save username to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _checkSavedUsername();
  }

  Future<void> _checkSavedUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    if (savedUsername != null && savedUsername.isNotEmpty) {
      _usernameController.text = savedUsername; // Fill username field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          title: null, // Remove the title
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school, // Change to university icon
                size: 100.0, // Set the size of the icon
                color: Colors.white, // Set the color of the icon
              ),
              SizedBox(height: 10.0), // Add spacing between icon and text
              Text(
                'College',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0, // Set the font size
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
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Enter Your Details',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ), // Reduce vertical padding
                labelStyle: TextStyle(fontSize: 14.0), // Adjust font size
              ),
            ),
            SizedBox(height: 40.0), // Increased spacing
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15.0,
                ), // Reduce vertical padding
                labelStyle: TextStyle(fontSize: 14.0), // Adjust font size
              ),
              obscureText: true,
            ),
            SizedBox(height: 40.0), // Increased spacing
            ElevatedButton(
              onPressed: () async {
                final username = _usernameController.text;
                final password = _passwordController.text;
                final isValid = await _checkLogin(username, password);
                if (isValid) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CollegeDashboard(
                        username: username,
                        onLogout: () {}, // Add onLogout parameter here
                      ),
                    ),
                  );
                } else {
                  // Show an error message or dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Invalid Credentials'),
                        content: Text('Username or password is incorrect.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Make button rectangular
                ),
              ),
              child: Text('Login'),
            ),
            SizedBox(
                height: 10.0), // Add space between button and additional text
            GestureDetector(
              onTap: () {
                // Navigate to CollegeSignup page when "Sign up" text is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CollegeSignup()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 16.0,
                      color:
                          Colors.deepPurple, // Make only "Sign up" deep purple
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
