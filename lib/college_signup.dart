import 'package:flutter/material.dart';
import 'package:project/college_login.dart'; // Import CollegeDashboard
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(CollegeSignup());
}

class CollegeSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupPage(), // Change to SignupPage
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _collegeNameController = TextEditingController();
  final TextEditingController _collegeEmailController = TextEditingController();
  final TextEditingController _collegePhoneController = TextEditingController();
  final TextEditingController _collegeAddressController =
      TextEditingController();
  final TextEditingController _contactPersonDetailsController =
      TextEditingController();
  final TextEditingController _collegeWebsiteUrlController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Database constants
  static const String _databaseName = 'collegedata.db';
  static const String _tableName = 'collegedata';
  static const int _databaseVersion = 1;

  // Database instance
  late Database _database;

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  // Open database connection
  Future<void> _openDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, username TEXT, collegeName TEXT, collegeEmail TEXT, collegePhone TEXT, collegeAddress TEXT, contactPersonDetails TEXT, collegeWebsiteUrl TEXT, password TEXT)",
        );
      },
      version: _databaseVersion,
    );
  }

  // Save form data to database
  Future<void> _saveToDatabase() async {
    await _database.insert(
      _tableName,
      {
        'username': _usernameController.text,
        'collegeName': _collegeNameController.text,
        'collegeEmail': _collegeEmailController.text,
        'collegePhone': _collegePhoneController.text,
        'collegeAddress': _collegeAddressController.text,
        'contactPersonDetails': _contactPersonDetailsController.text,
        'collegeWebsiteUrl': _collegeWebsiteUrlController.text,
        'password': _passwordController.text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Validate all fields
  bool _validateFields() {
    return _usernameController.text.isNotEmpty &&
        _collegeNameController.text.isNotEmpty &&
        _collegeEmailController.text.isNotEmpty &&
        _collegePhoneController.text.isNotEmpty &&
        _collegeAddressController.text.isNotEmpty &&
        _contactPersonDetailsController.text.isNotEmpty &&
        _collegeWebsiteUrlController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
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
                'College Signup', // Change to signup
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0, // Set the font size
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  ),
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _collegeNameController,
                decoration: InputDecoration(
                  labelText: 'College Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _collegeEmailController,
                decoration: InputDecoration(
                  labelText: 'College Email Address',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _collegePhoneController,
                decoration: InputDecoration(
                  labelText: 'College Phone No.',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _collegeAddressController,
                decoration: InputDecoration(
                  labelText: 'College Address',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _contactPersonDetailsController,
                decoration: InputDecoration(
                  labelText: 'Administrator/Contact Person Details',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _collegeWebsiteUrlController,
                decoration: InputDecoration(
                  labelText: 'College Website URL',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(height: 20.0),
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
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () async {
                  // Check if any field is empty
                  if (_validateFields()) {
                    // Save data to the database
                    await _saveToDatabase();
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CollegeLogin()),
                    );
                  } else {
                    // Display an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
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
      ),
    );
  }
}
