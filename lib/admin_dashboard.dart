import 'package:flutter/material.dart';
import 'student_user_data.dart'; // Import the StudentUserData page
import 'college_user_data.dart'; // Import the CollegeUserData page
import 'college_events_data.dart'; // Import the CollegeEventsData page

class AdminDashboard extends StatelessWidget {
  final String username;
  final VoidCallback onLogout;

  AdminDashboard({required this.username, required this.onLogout});

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
                'Admin Dashboard',
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
            ElevatedButton(
              onPressed: () {
                // Navigate to Student User Data page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentUserData()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 60), // Set button minimum size
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Set button border radius
                ),
                backgroundColor:
                    Colors.deepPurple, // Set button color to purple
              ),
              child: const Text(
                'Student User Data',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            SizedBox(height: 40), // Add more spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to College User Data page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CollegeUserData()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 60), // Set button minimum size
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Set button border radius
                ),
                backgroundColor:
                    Colors.deepPurple, // Set button color to purple
              ),
              child: const Text(
                'College User Data',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            SizedBox(height: 40), // Add more spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to College Events Data page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CollegeEventsData()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 60), // Set button minimum size
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Set button border radius
                ),
                backgroundColor:
                    Colors.deepPurple, // Set button color to purple
              ),
              child: const Text(
                'College Events Data',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
