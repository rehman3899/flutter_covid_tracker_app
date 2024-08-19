import 'package:flutter/material.dart'; // Import Flutter material design components
import 'package:flutter_covid_tracker/screens/splash_screen.dart'; // Import the SplashScreen widget

void main() {
  runApp(
      const MainApp()); // Run the application by starting with the MainApp widget
}

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key}); // Constructor for MainApp, with optional key parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Hide the debug banner in the top-right corner
      theme: ThemeData(
        brightness: Brightness.dark, // Set the app theme to dark mode
        primarySwatch: Colors.blue, // Set the primary color for the app
      ),
      home:
          const SplashScreen(), // Set the home screen of the app to SplashScreen
    );
  }
}
