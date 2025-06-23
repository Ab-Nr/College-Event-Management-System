import 'package:flutter/material.dart';
import 'package:project/student_login.dart'; // Import the StudentLogin page
import 'package:project/college_login.dart'; // Import the CollegeLogin page
import 'package:project/admin_login.dart'; // Import the AdminLogin page

void main() => runApp(const ChooseUser());

class ChooseUser extends StatelessWidget {
  const ChooseUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(200), // Adjust height as needed
            child: AppBar(
              backgroundColor:
                  Colors.deepPurple, // Set the background color to purple
              flexibleSpace: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.group, // Use the group icon from Material Icons
                      size: 100, // Set the size of the icon
                      color: Colors.white, // Set the color of the icon
                    ),
                    SizedBox(height: 10), // Add spacing between icon and text
                    Text(
                      'Choose User Type',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white), // Adjust font size and color
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to AdminLogin page when Admin button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLogin()),
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
                    'Admin',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
                SizedBox(height: 40), // Add more spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigate to StudentLogin page when Student button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentLogin()),
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
                    'Student',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
                SizedBox(height: 40), // Add more spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigate to CollegeLogin page when College button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CollegeLogin()),
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
                    'College',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
