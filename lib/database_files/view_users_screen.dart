import 'package:flutter/material.dart';
import 'package:project/database_files/database_helper.dart';

final dbHelper =
    DatabaseHelper.instance; // Use the named constructor 'instance'

class ViewUsersScreen extends StatefulWidget {
  @override
  _ViewUsersScreenState createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  // List to hold user details fetched from the database
  List<Map<String, dynamic>> _userDetails = [];

  // Function to fetch user details from the database
  Future<void> _fetchUserDetails() async {
    final users = await dbHelper.getAllUsers();
    setState(() {
      _userDetails = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Users'),
      ),
      body: _userDetails.isEmpty
          ? Center(
              child: Text('No users found.'),
            )
          : ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                final user = _userDetails[index];
                return ListTile(
                  title: Text(user['email']),
                  subtitle: Text(
                      '${user['student_name']} - ${user['institution_name']}'),
                  // Add additional fields as needed
                );
              },
            ),
    );
  }
}
