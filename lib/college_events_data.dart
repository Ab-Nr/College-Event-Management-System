import 'package:flutter/material.dart';
import 'package:project/college_dashboard.dart'; // Import the Event class and DatabaseHelper class

class CollegeEventsData extends StatefulWidget {
  @override
  _CollegeEventsDataState createState() => _CollegeEventsDataState();
}

class _CollegeEventsDataState extends State<CollegeEventsData> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() async {
    try {
      // Retrieve all events from the database
      List<Event> loadedEvents = await DatabaseHelper.instance.queryAllEvents();
      print('Loaded events: $loadedEvents'); // Debug print
      setState(() {
        events = loadedEvents;
      });
    } catch (e) {
      print('Error loading events: $e');
    }
  }

  void _deleteEvent(String title) async {
    try {
      // Delete event from the database
      await DatabaseHelper.instance.deleteEvent(title);
      // Reload events after deletion
      _loadEvents();
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Events Data'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Time')),
                  DataColumn(label: Text('Location')),
                  DataColumn(label: Text('Image')),
                  DataColumn(label: Text('Tickets')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Actions')), // New column for actions
                ],
                rows: events.map((event) {
                  return DataRow(cells: [
                    DataCell(Text(event.title)),
                    DataCell(Text(event.description)),
                    DataCell(Text(event.category)),
                    DataCell(Text(event.date != null
                        ? '${event.date!.day}/${event.date!.month}/${event.date!.year}'
                        : '')),
                    DataCell(Text(event.time != null
                        ? '${event.time!.hour}:${event.time!.minute}'
                        : '')),
                    DataCell(Text(event.location)),
                    DataCell(event.image.isNotEmpty
                        ? Image.network(event.image, width: 50, height: 50)
                        : Text('')),
                    DataCell(Text(event.tickets.toString())),
                    DataCell(Text('\$${event.price.toStringAsFixed(2)}')),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          _deleteEvent(event.title), // Call the delete method
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
