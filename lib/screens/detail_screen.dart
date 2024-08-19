import 'package:flutter/material.dart'; // Import Flutter material design components
import 'package:flutter_covid_tracker/screens/widgets/row_data_card.dart'; // Import custom widget for displaying data rows

// StatefulWidget to display detailed information about a specific country
class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.name, // Name of the country
    required this.image, // URL of the country's flag image
    required this.totalCases, // Total number of COVID-19 cases
    required this.totalDeaths, // Total number of COVID-19 deaths
    required this.totalRecovered, // Total number of recovered cases
    required this.active, // Number of active cases
    required this.critical, // Number of critical cases
    required this.todayRecovered, // Number of cases recovered today
    required this.test, // Total number of tests conducted
  });

  final String name, image; // Country name and flag image URL
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test; // COVID-19 statistics

  @override
  State<DetailScreen> createState() =>
      _DetailScreenState(); // Create the state for this widget
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.name), // Set the title of the AppBar to the country's name
        centerTitle: true, // Center the title in the AppBar
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the children vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center the children horizontally
        children: [
          Stack(
            alignment: Alignment
                .topCenter, // Align children at the top center of the Stack
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *
                        0.05), // Add top padding to the Card
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.05), // Add spacing at the top of the Card
                      // Custom widget to display data rows
                      CardDataRow(
                          title: 'Cases',
                          value: widget.totalCases
                              .toString()), // Display total cases
                      CardDataRow(
                          title: 'Recovered',
                          value: widget.totalRecovered
                              .toString()), // Display total recovered cases
                      CardDataRow(
                          title: 'Deaths',
                          value: widget.totalDeaths
                              .toString()), // Display total deaths
                      CardDataRow(
                          title: 'Active',
                          value:
                              widget.active.toString()), // Display active cases
                      CardDataRow(
                          title: 'Critical',
                          value: widget.critical
                              .toString()), // Display critical cases
                      CardDataRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered
                              .toString()), // Display recovered cases today
                      CardDataRow(
                          title: 'Tests',
                          value: widget.test
                              .toString()), // Display total tests conducted
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50, // Radius of the CircleAvatar
                backgroundImage:
                    NetworkImage(widget.image), // Display country's flag image
              ),
            ],
          ),
        ],
      ),
    );
  }
}
