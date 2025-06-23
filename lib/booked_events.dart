import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

void main() {
  runApp(EventsPage());
}

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Events',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TechnicalEvents(),
              CulturalEvents(),
              WorkshopEvents(),
              SeminarEvents(),
            ],
          ),
        ),
      ),
    );
  }
}

class TechnicalEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Technical Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          EventCard(
            eventTitle: 'Tech fest',
            eventPoster: 'assets/scms.jpeg',
            eventDescription:
                'A techfest is an event showcasing science, engineering, and technology through competitions, exhibitions, and workshops.',
            eventType: 'Technical',
            eventDate: 'May 10, 2024',
            eventLocation: 'https://maps.app.goo.gl/YZDfRjkXyeXs1gof6',
            eventTiming: '4:00 PM',
          ),
          // Add more Technical event cards here if needed
        ],
      ),
    );
  }
}

class CulturalEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Cultural Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          EventCard(
            eventTitle: 'Cultural Fest 2',
            eventPoster: 'assets/fisat2.jpg',
            eventDescription:
                'A cultural fest is an event that celebrates the diverse cultural heritage of a community through various activities such as dance, music, art, and food.',
            eventType: 'Cultural',
            eventDate: 'May 12, 2024',
            eventLocation: 'https://maps.app.goo.gl/S77R1fXd6y84xFWo7',
            eventTiming: '6:00 PM',
          ),
          // Add more Cultural event cards here if needed
        ],
      ),
    );
  }
}

class WorkshopEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Workshop Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          EventCard(
            eventTitle: 'Workshop 3',
            eventPoster: 'assets/rajagiri.jpg',
            eventDescription:
                'A workshop is an educational session that provides hands-on learning and practical skills in a specific area such as technology, arts, or business.',
            eventType: 'Workshop',
            eventDate: 'May 15, 2024',
            eventLocation: 'https://maps.app.goo.gl/YZDfRjkXyeXs1gof6',
            eventTiming: '10:00 AM',
          ),
          // Add more Workshop event cards here if needed
        ],
      ),
    );
  }
}

class SeminarEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Seminar Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          EventCard(
            eventTitle: 'Seminar 4',
            eventPoster: 'assets/nit.jpeg',
            eventDescription:
                'A seminar is a conference or other meeting for discussion or training. It typically leads to a presentation or speech, with questions from the audience.',
            eventType: 'Seminar',
            eventDate: 'May 20, 2024',
            eventLocation: 'https://maps.app.goo.gl/YVsNe7qau7zn2DAw9',
            eventTiming: '10:00 AM',
          ),
          // Add more Seminar event cards here if needed
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventTitle;
  final String eventPoster;
  final String eventDescription;
  final String eventType;
  final String eventDate;
  final String eventLocation;
  final String eventTiming;

  const EventCard({
    Key? key,
    required this.eventTitle,
    required this.eventPoster,
    required this.eventDescription,
    required this.eventType,
    required this.eventDate,
    required this.eventLocation,
    required this.eventTiming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            child: Image.asset(
              eventPoster,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              eventTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              eventDescription,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Event Type: $eventType',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Date: $eventDate',
              style: TextStyle(
                fontSize: 10,
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
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(Icons.access_time),
            title: Text(
              eventTiming,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
