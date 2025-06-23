import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StudentUserData extends StatefulWidget {
  @override
  _StudentUserDataState createState() => _StudentUserDataState();
}

class _StudentUserDataState extends State<StudentUserData> {
  List<Map<String, dynamic>> _userDetails = [];

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    String path = join(await getDatabasesPath(), 'user_details.db');
    Database database = await openDatabase(path);

    List<Map<String, dynamic>> userDetails =
        await database.query('user_details');

    setState(() {
      _userDetails = userDetails;
    });

    await database.close();
  }

  Future<void> _deleteUser(int id) async {
    String path = join(await getDatabasesPath(), 'user_details.db');
    Database database = await openDatabase(path);

    await database.delete('user_details', where: 'id = ?', whereArgs: [id]);

    setState(() {
      _userDetails.removeWhere((user) => user['id'] == id);
    });

    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student User Data'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _userDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Password')),
                      DataColumn(label: Text('Student Name')),
                      DataColumn(label: Text('Institution Name')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _userDetails.map((user) {
                      return DataRow(cells: [
                        DataCell(Text(user['id'].toString())),
                        DataCell(Text(user['email'])),
                        DataCell(Text(user['password'])),
                        DataCell(Text(user['student_name'])),
                        DataCell(Text(user['institution_name'])),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              _deleteUser(user['id']);
                            },
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
    );
  }
}
