import 'package:flutter/material.dart'; // Import Flutter material design components
import 'package:flutter_covid_tracker/models/world_states_model.dart'; // Import the model for world states
import 'package:flutter_covid_tracker/screens/countries_list_screen.dart'; // Import the countries list screen
import 'package:flutter_covid_tracker/screens/widgets/row_data_card.dart';
import 'package:flutter_covid_tracker/services/states_services.dart'; // Import the service for fetching state data
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import SpinKit for loading indicators
import 'package:pie_chart/pie_chart.dart'; // Import PieChart for displaying data in a pie chart

// StatefulWidget to manage and display world states
class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key}); // Constructor for the widget

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState(); // Create the state for this widget
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin { // TickerProvider for animation
  late final AnimationController _controller; // Animation controller for the loading spinner

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller for the spinner
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Duration of the animation
      vsync: this, // Provide this widget as the vsync provider
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose of the animation controller
  }

  // List of colors used in the pie chart
  final colorList = <Color>[
    const Color(0xff4284F4), // Blue color
    const Color(0xff1aa260), // Green color
    const Color(0xffde5246), // Red color
  ];

  @override
  Widget build(BuildContext context) {
    // Create an instance of the states service
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Set height to screen height
          width: MediaQuery.of(context).size.width, // Set width to screen width
          child: Padding(
            padding: const EdgeInsets.all(15.0), // Padding around the content
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015, // Spacer
                ),
                // FutureBuilder to handle asynchronous data fetching
                FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(), // Fetch data from the service
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      // Show a loading spinner if data is not yet available
                      return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _controller,
                          size: 50,
                        ),
                      );
                    } else {
                      // Once data is available, build the UI
                      return Column(
                        children: [
                          // Pie chart to display COVID-19 statistics
                          PieChart(
                            dataMap: {
                              'Total': double.parse(
                                  snapshot.data!.cases!.toString()), // Total cases
                              'Recovered': double.parse(
                                  snapshot.data!.recovered!.toString()), // Recovered cases
                              'Deaths': double.parse(
                                  snapshot.data!.deaths!.toString()), // Deaths
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true, // Show values as percentages
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2, // Chart radius
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left, // Position of legend
                            ),
                            animationDuration:
                                const Duration(microseconds: 1200), // Animation duration
                            colorList: colorList, // Colors for the pie chart segments
                            chartType: ChartType.ring, // Ring chart type
                          ),
                          // Padding for spacing
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06, // Vertical padding
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  // Display various statistics in a card
                                  CardDataRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString()),
                                  CardDataRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  CardDataRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  CardDataRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  CardDataRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  CardDataRow(
                                      title: 'Today Cases',
                                      value:
                                          snapshot.data!.todayCases.toString()),
                                  CardDataRow(
                                      title: 'Today Deaths',
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  CardDataRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          // Button to navigate to the countries list screen
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CountriesListScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50, // Height of the button
                              decoration: BoxDecoration(
                                color: const Color(0xff1aa260), // Button color
                                borderRadius: BorderRadius.circular(10), // Rounded corners
                              ),
                              child: const Center(
                                child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500, // Font weight of the button text
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// You can also use a MaterialButton instead of InkWell
                          /*
                          MaterialButton(
                            onPressed: () {},
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width,
                            color: const Color(0xff1aa260),
                            child: const Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          */
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


