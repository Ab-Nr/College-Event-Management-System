import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'college_dashboard.dart'; // Import the college_dashboard.dart for Event and DatabaseHelper

void main() {
  runApp(TechnicalEventsScreen());
}

class TechnicalEventsScreen extends StatefulWidget {
  @override
  _TechnicalEventsScreenState createState() => _TechnicalEventsScreenState();
}

class _TechnicalEventsScreenState extends State<TechnicalEventsScreen> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() async {
    List<Event> loadedEvents = await DatabaseHelper.instance.queryAllEvents();
    setState(() {
      events = loadedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Technical Events',
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
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  eventTitle: event.title,
                  eventPoster: event.image.isNotEmpty
                      ? event.image
                      : 'assets/default.jpg', // Use a default image if not provided
                  eventDescription: event.description,
                  eventType: event.category,
                  eventLocation: event.location,
                  eventTiming: '${event.time?.hour}:${event.time?.minute}',
                  eventDate:
                      '${event.date?.year}-${event.date?.month}-${event.date?.day}', // Format the date
                  collegeWebsite:
                      '', // Replace with actual website if available
                );
              },
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
