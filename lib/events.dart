import 'package:flutter/material.dart';
import 'package:project/tech_events.dart';
import 'package:project/cultural_events.dart';
import 'package:project/seminar.dart'; // Import the SeminarScreen
import 'package:project/workshops.dart'; // Import the WorkshopScreen
import 'package:project/booked_events.dart'; // Import the BookedEventsScreen
import 'package:project/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventsScreen(),
    );
  }
}

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Bar for Hello Student
          Container(
            color: Colors.deepPurple, // Darker shade of violet
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.white), // User icon
                SizedBox(width: 10.0), // Add spacing
                Text(
                  'Hello, Student',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0), // Add more spacing
          // Discover Events Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Discover Exciting Events',
              textAlign: TextAlign.left, // Align to the left
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10.0), // Add more spacing
          // Search Bar with Dark Border
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.black), // Added dark border
              ),
              child: Row(
                children: [
                  SizedBox(width: 10.0), // Add spacing for search icon
                  Icon(Icons.search), // Search icon
                  SizedBox(width: 10.0), // Add spacing
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Events...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0), // Add more spacing
          // Category Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TechnicalEventsScreen(),
                    ),
                  );
                },
                child: CategoryButton(
                  text: 'Technical',
                  icon: Icons.computer,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TechnicalEventsScreen(),
                      ),
                    );
                  },
                  height: 180.0, // Increase button height
                  width: 180.0, // Set button width
                  color: Colors.purple[200], // Light purple color
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CulturalEventsScreen(),
                    ),
                  );
                },
                child: CategoryButton(
                  text: 'Cultural',
                  icon: Icons.palette,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CulturalEventsScreen(),
                      ),
                    );
                  },
                  height: 180.0, // Increase button height
                  width: 180.0, // Set button width
                  color: Colors.yellow, // Yellow color
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0), // Add more spacing
          // Category Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkshopScreen(),
                    ),
                  );
                },
                child: CategoryButton(
                  text: 'Workshops',
                  icon: Icons.build,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkshopScreen(),
                      ),
                    );
                  },
                  height: 180.0, // Increase button height
                  width: 175.0, // Set button width
                  color: Colors.lightBlue, // Light blue color
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeminarScreen(),
                    ),
                  );
                },
                child: CategoryButton(
                  text: 'Seminars',
                  icon: Icons.mic,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeminarScreen(),
                      ),
                    );
                  },
                  height: 180.0, // Increase button height
                  width: 175.0, // Set button width
                  color: Colors.lightGreen, // Light green color
                ),
              ),
            ],
          ),
          Spacer(), // Add spacer to push the bottom navigation bar to the bottom
          // Bottom Navigation Bar
          BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor:
                Colors.deepPurple, // Deep purple color for selected item
            unselectedItemColor: Colors.grey, // Grey color for unselected items
            showUnselectedLabels: true, // Show labels for unselected items
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 20.0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 20.0),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  // Wrap the events icon with GestureDetector
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventsPage(), // Navigate to BookedEventsScreen
                      ),
                    );
                  },
                  child: Icon(Icons.event, size: 20.0), // Events icon
                ),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  },
                  child: Icon(Icons.person, size: 20.0), // Profile icon
                ),
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final Color? color;

  const CategoryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 16.0), // Set font size
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: Size(width ?? 100.0, height ?? 200.0), // Set button size
      ),
    );
  }
}