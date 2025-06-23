import 'package:flutter/material.dart';
import 'choose_user.dart'; // Importing the choose_user.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/choose_user': (context) =>
            ChooseUser(), // Add a route to the ChooseUser page
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor:
              Colors.deepPurple, // Set app bar background color to violet
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  30.0), // Set button shape to rounded rectangle
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0), // Set button padding
            minimumSize: Size(200.0, 50.0), // Set button size
          ).copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.deepPurple), // Set button color to violet
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                fontSize: 18.0,
                color: Colors.white)), // Set text color to white
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        centerTitle: true,
        leading: Icon(
          Icons.explore,
          color: Colors.white, // Set icon color to white
        ), // Add compass icon to the left end of the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Discover Technical Events
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Discover Events',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Large Image
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/conference5.jpg', // Updated path to the image
                fit: BoxFit.cover,
              ),
            ),
            // Browse Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/choose_user'); // Navigate to choose_user page
                },
                child: Text(
                  'Browse',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white), // Set text color to white
                ),
              ),
            ),
            SizedBox(height: 40.0), // Add more spacing
          ],
        ),
      ),
    );
  }
}
