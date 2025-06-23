import 'package:flutter/material.dart';

void main() {
  runApp(WorkshopScreen());
}

class WorkshopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Workshops',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white, // Set text color to white
            ),
          ),
          centerTitle: true,
        ),
        body: EventCreationPage(), // Display EventCreationPage as body
      ),
    );
  }
}

class EventCreationPage extends StatefulWidget {
  @override
  _EventCreationPageState createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {
  String selectedCategory =
      'Technical'; // Define selectedCategory and set its initial value

  List<Event> events = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ticketsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Event Title'),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Event Description'),
            maxLines: 3,
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: InputDecoration(labelText: 'Event Category'),
            value: selectedCategory, // Set the value to selectedCategory
            items: ['Technical', 'Cultural', 'Workshop', 'Seminar']
                .map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              // Update selectedCategory when dropdown value changes
              setState(() {
                selectedCategory = value.toString();
              });
            },
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Event Date'),
            onTap: () {
              // Show date picker
            },
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _timeController,
            decoration: InputDecoration(labelText: 'Event Time'),
            onTap: () {
              // Show time picker
            },
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Event Location'),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _ticketsController,
            decoration: InputDecoration(labelText: 'No. of tickets'),
            keyboardType: TextInputType.number, // Only allow numeric input
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price of ticket'),
            keyboardType: TextInputType.numberWithOptions(
                decimal: true), // Allow decimal input
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Event Image/Poster'),
                ),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to upload image
                },
                child: Text('Upload'),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Handle event creation
              if (selectedCategory == 'Workshop') {
                // Only add event if category is Workshop
                setState(() {
                  events.add(Event(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    category: selectedCategory,
                    date: _dateController.text,
                    time: _timeController.text,
                    location: _locationController.text,
                    tickets: int.tryParse(_ticketsController.text) ?? 0,
                    price: double.tryParse(_priceController.text) ?? 0.0,
                  ));
                });
              }
            },
            child: Text('Create Event'),
          ),
          SizedBox(height: 20.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(event: events[index]);
            },
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  final String category;
  final String date;
  final String time;
  final String location;
  final int tickets;
  final double price;

  Event({
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.tickets,
    required this.price,
  });
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${event.description}'),
            Text('Category: ${event.category}'),
            Text('Date: ${event.date}'),
            Text('Time: ${event.time}'),
            Text('Location: ${event.location}'),
            Text('No. of tickets: ${event.tickets}'),
            Text('Price of ticket: ${event.price}'),
          ],
        ),
      ),
    );
  }
}
