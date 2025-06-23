import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:project/college_login.dart';

void main() async {
  String? loggedInUsername = await getLoggedInUsername();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => CollegeDashboard(
          username: loggedInUsername ?? 'default_username',
          onLogout: () {
            // Navigate back to the login page when logout is triggered
            Navigator.pushReplacementNamed(context, '/login');
          }),
      '/login': (context) => LoginPage(),
    },
  ));
}

Future<String?> getLoggedInUsername() async {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final loggedInUser = await databaseHelper.getCurrentLoggedInUser();
  if (loggedInUser != null) {
    return loggedInUser.username;
  }
  return null;
}

class CollegeDashboard extends StatelessWidget {
  final String username;
  final Function() onLogout;

  const CollegeDashboard(
      {Key? key, required this.username, required this.onLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(username: username, onLogout: onLogout),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final String username;
  final Function() onLogout;

  const DashboardScreen(
      {Key? key, required this.username, required this.onLogout})
      : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Event> events = [];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() async {
    List<Event> loadedEvents;
    if (selectedCategory == 'All') {
      loadedEvents =
          await DatabaseHelper.instance.queryUserEvents(widget.username);
    } else {
      loadedEvents = await DatabaseHelper.instance
          .queryEventsByCategory(widget.username, selectedCategory);
    }
    setState(() {
      events = loadedEvents;
    });
  }

  void _addEvent(Event event) async {
    await DatabaseHelper.instance.insert(event);
    setState(() {
      events.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8.0),
              Icon(Icons.school),
              SizedBox(width: 8.0),
              Text('College Dashboard'),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            // Remove all events before logging out
            await DatabaseHelper.instance.deleteAllEvents();
            widget.onLogout();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Technical'),
              onTap: () {
                setState(() {
                  selectedCategory = 'Technical';
                });
                _loadEvents();
              },
            ),
            ListTile(
              title: Text('Cultural'),
              onTap: () {
                setState(() {
                  selectedCategory = 'Cultural';
                });
                _loadEvents();
              },
            ),
            ListTile(
              title: Text('Workshops'),
              onTap: () {
                setState(() {
                  selectedCategory = 'Workshops';
                });
                _loadEvents();
              },
            ),
            ListTile(
              title: Text('Seminars'),
              onTap: () {
                setState(() {
                  selectedCategory = 'Seminars';
                });
                _loadEvents();
              },
            ),
            ListTile(
              title: Text('All Events'),
              onTap: () {
                setState(() {
                  selectedCategory = 'All';
                });
                _loadEvents();
              },
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var event in events) ...[
                Card(
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.description),
                        SizedBox(height: 4.0),
                        Text(
                          'Category: ${event.category}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (event.date != null && event.time != null) ...[
                          SizedBox(height: 4.0),
                          Text(
                            'Date: ${event.date!.day}/${event.date!.month}/${event.date!.year} ${event.time!.hour}:${event.time!.minute}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                        if (event.location.isNotEmpty) ...[
                          SizedBox(height: 4.0),
                          Text(
                            'Location: ${event.location}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                        if (event.image.isNotEmpty) ...[
                          SizedBox(height: 8.0),
                          CachedNetworkImage(
                            imageUrl: event.image,
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Column(
                              children: [
                                Icon(Icons.error),
                                Text('Failed to load image'),
                              ],
                            ),
                          ),
                        ],
                        SizedBox(height: 4.0),
                        Text(
                          'No. of tickets: ${event.tickets}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price of ticket: \$${event.price.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // Delete the event from the database
                        await DatabaseHelper.instance.deleteEvent(event.title);
                        // Update the state to reflect changes
                        setState(() {
                          events.remove(event);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventCreationPage(
                        onEventCreated: _addEvent,
                        loggedInUsername: widget.username),
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 44.0,
            child: FloatingActionButton(
              onPressed: () {
                // Add functionality for the delete button
                if (events.isNotEmpty) {
                  setState(() {
                    events.removeAt(0);
                  });
                }
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.delete),
            ),
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
  final DateTime? date;
  final TimeOfDay? time;
  final String location;
  final String image;
  final int tickets;
  final double price;
  late String username;

  Event({
    required this.title,
    required this.description,
    required this.category,
    this.date,
    this.time,
    this.location = '',
    this.image = '',
    required this.tickets,
    required this.price,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'date': date?.toIso8601String(), // Use ISO8601 string for date
      'time': time != null ? '${time!.hour}:${time!.minute}' : null,
      'location': location,
      'image': image,
      'tickets': tickets,
      'price': price,
      'username': username,
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      description: map['description'],
      category: map['category'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      time: map['time'] != null
          ? TimeOfDay(
              hour: int.parse(map['time'].split(':')[0]),
              minute: int.parse(map['time'].split(':')[1]),
            )
          : null,
      location: map['location'],
      image: map['image'],
      tickets: map['tickets'],
      price: map['price'],
      username: map['username'],
    );
  }
}

class EventCreationPage extends StatefulWidget {
  final Function(Event) onEventCreated;
  final String loggedInUsername;

  EventCreationPage(
      {required this.onEventCreated, required this.loggedInUsername});

  @override
  _EventCreationPageState createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {
  String _title = '';
  String _description = '';
  String _category = 'Technical'; // Default category
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _location = '';
  String _imageURL = '';
  int _tickets = 0;
  double _price = 0.0;

  // Define the list of categories
  List<String> _categories = ['Technical', 'Cultural', 'Workshops', 'Seminars'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              // Replace TextField with DropdownButtonFormField
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                value: _category,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              SizedBox(height: 8.0),
              Text(
                _selectedDate == null
                    ? 'No Date Chosen'
                    : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select Date'),
              ),
              SizedBox(height: 8.0),
              Text(
                _selectedTime == null
                    ? 'No Time Chosen'
                    : 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}',
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Select Time'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Image URL'),
                onChanged: (value) {
                  setState(() {
                    _imageURL = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Number of Tickets'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _tickets = int.parse(value);
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price of Ticket'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    _price = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final event = Event(
                    title: _title,
                    description: _description,
                    category: _category,
                    date: _selectedDate,
                    time: _selectedTime,
                    location: _location,
                    image: _imageURL,
                    tickets: _tickets,
                    price: _price,
                    username: widget.loggedInUsername,
                  );
                  widget.onEventCreated(event);
                  Navigator.pop(context);
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'events_create.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS events(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        category TEXT,
        date TEXT,
        time TEXT,
        location TEXT,
        image TEXT,
        tickets INTEGER,
        price REAL,
        username TEXT
      )
      ''');
  }

  Future<int> insert(Event event) async {
    Database db = await instance.database;
    return await db.insert('events', event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Event>> queryUserEvents(String username) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('events',
        where: 'username = ?',
        whereArgs: [username],
        orderBy: 'date ASC, time ASC');
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<List<Event>> queryEventsByCategory(
      String username, String category) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('events',
        where: 'username = ? AND category = ?',
        whereArgs: [username, category],
        orderBy: 'date ASC, time ASC');
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<void> deleteEvent(String title) async {
    Database db = await instance.database;
    await db.delete(
      'events',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<void> deleteAllEvents() async {
    Database db = await instance.database;
    await db.delete('events');
  }

  Future<User?> getCurrentLoggedInUser() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('collegedata', columns: ['username'], limit: 1);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Event>> queryAllEvents() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('events', orderBy: 'date ASC, time ASC');
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }
}

class User {
  final String username;

  User({required this.username});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
    );
  }
}
