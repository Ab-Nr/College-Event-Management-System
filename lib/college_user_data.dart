import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CollegeUserData extends StatefulWidget {
  @override
  _CollegeUserDataState createState() => _CollegeUserDataState();
}

class _CollegeUserDataState extends State<CollegeUserData> {
  List<Map<String, dynamic>> _collegeDetails = [];

  @override
  void initState() {
    super.initState();
    _fetchCollegeDetails();
  }

  Future<void> _fetchCollegeDetails() async {
    String path = join(await getDatabasesPath(), 'collegedata.db');
    Database database = await openDatabase(path);

    List<Map<String, dynamic>> collegeDetails =
        await database.query('collegedata');

    setState(() {
      _collegeDetails = collegeDetails;
    });

    await database.close();
  }

  Future<void> _deleteCollegeUser(int id) async {
    String path = join(await getDatabasesPath(), 'collegedata.db');
    Database database = await openDatabase(path);

    await database.delete('collegedata', where: 'id = ?', whereArgs: [id]);

    setState(() {
      _collegeDetails.removeWhere((user) => user['id'] == id);
    });

    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College User Data'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _collegeDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Username')),
                      DataColumn(label: Text('College Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Contact Person')),
                      DataColumn(label: Text('Website')),
                      DataColumn(label: Text('Password')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _collegeDetails.map((college) {
                      return DataRow(cells: [
                        DataCell(Text(college['id'].toString())),
                        DataCell(Text(college['username'])),
                        DataCell(Text(college['collegeName'])),
                        DataCell(Text(college['collegeEmail'])),
                        DataCell(Text(college['collegePhone'])),
                        DataCell(Text(college['collegeAddress'])),
                        DataCell(Text(college['contactPersonDetails'])),
                        DataCell(Text(college['collegeWebsiteUrl'])),
                        DataCell(Text(college['password'])),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              _deleteCollegeUser(college['id']);
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
