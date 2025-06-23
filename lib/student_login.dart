import 'package:flutter/material.dart';
import 'package:project/events.dart';
import 'package:project/student_signup.dart'; // Import the SignupPage file
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StudentLogin extends StatelessWidget {
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to retrieve user details from the database
  Future<Map<String, dynamic>?> _getUserDetails(String email) async {
    String path = join(await getDatabasesPath(), 'user_details.db');
    Database database = await openDatabase(path);
    List<Map<String, dynamic>> result = await database
        .query('user_details', where: 'email = ?', whereArgs: [email]);
    await database.close();
    return result.isNotEmpty ? result.first : null;
  }

  // Function to validate text fields
  bool _validateFields() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return false; // Return false if any field is empty
    }
    return true; // Return true if all fields are filled
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
                'Student',
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
            ElevatedButton(
              onPressed: () async {
                if (!_validateFields()) {
                  // Show error message if any field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all fields.'),
                    ),
                  );
                  return; // Exit function
                }

                String email = _emailController.text;
                String password = _passwordController.text;

                // Retrieve user details from the database
                Map<String, dynamic>? userDetails =
                    await _getUserDetails(email);

                if (userDetails != null &&
                    userDetails['password'] == password) {
                  // Navigate to EventsScreen if email and password match
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventsScreen()),
                  );
                } else {
                  // Display error message if email or password is incorrect
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Incorrect email or password.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
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
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Login'),
            ),
            SizedBox(
              height: 10.0,
            ), // Add space between button and additional text
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
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
                      color: Colors.deepPurple,
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
