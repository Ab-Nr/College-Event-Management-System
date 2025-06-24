import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

void main() {
  runApp(CulturalEventsScreen());
}

class CulturalEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Cultural Events',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white, // Set text color to white
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Scrollbar(
            child: ListView(
              children: [
                EventCard(
                  eventTitle: 'Cultural Fest 1',
                  eventPoster: 'assets/', // Path to your image asset
                  eventDescription:
                      'A cultural fest is an event that celebrates the diverse cultural heritage of a community through various activities such as dance, music, art, and food.',
                  eventType: 'Cultural',
                  eventLocation: '',
                  eventTiming: '6:00 PM',
                  eventDate: '2024-05-20', // Added event date
                  collegeWebsite: '',
                ),
                SizedBox(height: 20),
                EventCard(
                  eventTitle: 'Cultural Fest 2',
                  eventPoster: 'assets/',
                  eventDescription:
                      'A cultural fest is an event that celebrates the diverse cultural heritage of a community through various activities such as dance, music, art, and food.',
                  eventType: 'Cultural',
                  eventLocation: '',
                  eventTiming: '7:00 PM',
                  eventDate: '2024-05-21', // Added event date
                  collegeWebsite: '',
                ),
                SizedBox(height: 20),
                EventCard(
                  eventTitle: 'Cultural Fest 3',
                  eventPoster: 'assets/',
                  eventDescription:
                      'A cultural fest is an event that celebrates the diverse cultural heritage of a community through various activities such as dance, music, art, and food.',
                  eventType: 'Cultural',
                  eventLocation: '',
                  eventTiming: '6:00 PM',
                  eventDate: '2024-05-22', // Added event date
                  collegeWebsite:
                      '',
                ),
                SizedBox(height: 20),
                EventCard(
                  eventTitle: 'Cultural Fest 4',
                  eventPoster: 'assets/',
                  eventDescription:
                      'A cultural fest is an event that celebrates the diverse cultural heritage of a community through various activities such as dance, music, art, and food.',
                  eventType: 'Cultural',
                  eventLocation: '',
                  eventTiming: '7:00 PM',
                  eventDate: '2024-05-23', // Added event date
                  collegeWebsite: '',
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventTitle;
  final String eventPoster;
  final String eventDescription;
  final String eventType;
  final String eventLocation;
  final String eventTiming;
  final String eventDate; // Added event date
  final String collegeWebsite;

  const EventCard({
    Key? key,
    required this.eventTitle,
    required this.eventPoster,
    required this.eventDescription,
    required this.eventType,
    required this.eventLocation,
    required this.eventTiming,
    required this.eventDate, // Update constructor to accept event date
    required this.collegeWebsite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150, // Set height for the image container
            child: Image.asset(
              eventPoster,
              fit: BoxFit.cover, // Ensure the image covers the container
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              eventTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16, // smaller font size
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              eventDescription,
              style: TextStyle(
                fontSize: 12, // smaller text size
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Event Type: $eventType', // Display event type
              style: TextStyle(
                fontSize: 10, // smaller text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(Icons.location_on),
            title: GestureDetector(
              onTap: () {
                _launchURL(eventLocation);
              },
              child: Text(
                eventLocation,
                style: TextStyle(
                  fontSize: 10,
                  decoration: TextDecoration
                      .underline, // Add underline to indicate it's clickable
                  color: Colors.blue, // Set text color to blue
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(Icons.access_time),
            title: Text(
              'Event Date: $eventDate', // Display event date
              style: TextStyle(fontSize: 10), // smaller text size
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(Icons.access_time),
            title: Text(
              eventTiming,
              style: TextStyle(fontSize: 10), // smaller text size
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(Icons.link),
            title: TextButton(
              onPressed: () {
                _launchURL(collegeWebsite); // Call _launchURL function on tap
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple, // Purple background color
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16), // Increased padding
                child: Text(
                  'Book Now',
                  style: TextStyle(
                      fontSize: 12, color: Colors.white), // White text color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to launch URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
