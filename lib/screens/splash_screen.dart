import 'dart:async'; // Importing Dart's asynchronous support library for Timer
import 'package:flutter/material.dart'; // Importing Flutter material package for UI components
import 'dart:math'
    as math; // Importing Dart's math library for mathematical operations
import 'package:flutter_covid_tracker/screens/world_states_screen.dart'; // Importing the WorldStatesScreen for navigation

// A StatefulWidget for the splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// The state class for SplashScreen
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController
      _controller; // AnimationController to control the rotation animation

  @override
  void initState() {
    super.initState();
    // Initializing the AnimationController with a duration and setting it to repeat
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Animation duration of 3 seconds
      vsync: this, // Using this state as the vsync provider
    )..repeat(); // Repeating the animation indefinitely

    // Setting a Timer to navigate to WorldStatesScreen after 5 seconds
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const WorldStatesScreen(), // Navigating to WorldStatesScreen
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Disposing the AnimationController when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centering column contents vertically
          crossAxisAlignment: CrossAxisAlignment
              .center, // Centering column contents horizontally
          children: [
            AnimatedBuilder(
              animation: _controller, // Animation to listen for changes
              child: const SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Image(
                    image: AssetImage(
                        'assets/images/virus.png'), // Displaying a virus image
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                // Rotating the child widget based on the animation controller's value
                return Transform.rotate(
                  angle:
                      _controller.value * 2.0 * math.pi, // Rotating 360 degrees
                  child: child,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.06, // Dynamic space between image and text
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Covid-19\nTracker App', // Displaying the app title
                textAlign: TextAlign.center, // Center aligning the text
                style: TextStyle(
                  fontSize: 25, // Text size
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
