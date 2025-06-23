import 'package:flutter/material.dart';
import 'package:project/admin_dashboard.dart'; // Ensure this path is correct
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(AdminLogin());
}

class AdminLogin extends StatelessWidget {
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

  Future<bool> _checkLogin(String username, String password) async {
    // Simulate authentication logic
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Check if username and password match the expected credentials
    if (username == 'admin' && password == 'admin') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      return true;
    }
    return false;
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
                Icons.admin_panel_settings, // Change to university icon
                size: 100.0, // Set the size of the icon
                color: Colors.white, // Set the color of the icon
              ),
              SizedBox(height: 10.0), // Add spacing between icon and text
              Text(
                'Admin',
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
                      builder: (BuildContext context) => AdminDashboard(
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
          ],
        ),
      ),
    );
  }
}
