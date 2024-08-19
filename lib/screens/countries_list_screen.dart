import 'package:flutter/material.dart'; // Import Flutter material design components
import 'package:flutter_covid_tracker/screens/detail_screen.dart'; // Import the detail screen for country info
import 'package:flutter_covid_tracker/services/states_services.dart'; // Import the service for fetching country data
import 'package:shimmer/shimmer.dart'; // Import Shimmer for loading effects

// StatefulWidget to manage and display a list of countries
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key}); // Constructor for the widget

  @override
  State<CountriesListScreen> createState() =>
      _CountriesListScreenState(); // Create the state for this widget
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController =
      TextEditingController(); // Controller for the search input

  @override
  Widget build(BuildContext context) {
    // Create an instance of the states service
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .scaffoldBackgroundColor, // Set AppBar background color
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search field for filtering the list of countries
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller:
                    searchController, // Controller for handling input text
                onChanged: (value) {
                  setState(
                      () {}); // Update the UI when the search input changes
                },
                decoration: InputDecoration(
                  hintText:
                      'Search with country name', // Placeholder text for the search field
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20), // Padding inside the search field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        50), // Rounded corners for the border
                  ),
                ),
              ),
            ),
            // Expanded widget to ensure the list takes up available space
            Expanded(
              child: FutureBuilder(
                future: statesServices
                    .fetchCountriesListRecords(), // Fetch country data
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    // Show loading shimmer effect if data is not yet available
                    return ListView.builder(
                      itemCount: 10, // Number of shimmer placeholders
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor:
                              Colors.grey.shade700, // Base color of the shimmer
                          highlightColor: Colors
                              .grey.shade100, // Highlight color of the shimmer
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 6.0),
                                child: ListTile(
                                  title: Container(
                                      height:
                                          10, // Height of the shimmer placeholder
                                      width:
                                          100, // Width of the shimmer placeholder
                                      color: Colors.white),
                                  subtitle: Container(
                                      height:
                                          10, // Height of the shimmer placeholder
                                      width:
                                          100, // Width of the shimmer placeholder
                                      color: Colors.white),
                                  leading: Container(
                                      height:
                                          50, // Height of the shimmer placeholder
                                      width:
                                          50, // Width of the shimmer placeholder
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    // Display the list of countries if data is available
                    return ListView.builder(
                      itemCount: snapshot.data!.length, // Number of countries
                      itemBuilder: (context, index) {
                        String name =
                            snapshot.data![index]['country']; // Country name

                        // Check if the search field is empty
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 6.0),
                                child: InkWell(
                                  onTap: () {
                                    // Navigate to detail screen when a country is tapped
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          image: snapshot.data![index]
                                                  ['countryInfo']
                                              ['flag'], // Country flag
                                          name: snapshot.data![index]
                                              ['country'], // Country name
                                          totalCases: snapshot.data![index]
                                              ['cases'], // Total cases
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'], // Total recovered
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'], // Total deaths
                                          active: snapshot.data![index]
                                              ['active'], // Active cases
                                          test: snapshot.data![index]
                                              ['tests'], // Total tests
                                          todayRecovered: snapshot.data![index][
                                              'todayRecovered'], // Recovered today
                                          critical: snapshot.data![index]
                                              ['critical'], // Critical cases
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(snapshot.data![index]
                                          ['country']), // Display country name
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()), // Display total cases
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot
                                                .data![index]['countryInfo']
                                            ['flag']), // Display country flag
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          // Display country if it matches the search query
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 6.0),
                                child: InkWell(
                                  onTap: () {
                                    // Navigate to detail screen when a country is tapped
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          image: snapshot.data![index]
                                                  ['countryInfo']
                                              ['flag'], // Country flag
                                          name: snapshot.data![index]
                                              ['country'], // Country name
                                          totalCases: snapshot.data![index]
                                              ['cases'], // Total cases
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'], // Total recovered
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'], // Total deaths
                                          active: snapshot.data![index]
                                              ['active'], // Active cases
                                          test: snapshot.data![index]
                                              ['tests'], // Total tests
                                          todayRecovered: snapshot.data![index][
                                              'todayRecovered'], // Recovered today
                                          critical: snapshot.data![index]
                                              ['critical'], // Critical cases
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(snapshot.data![index]
                                          ['country']), // Display country name
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()), // Display total cases
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot
                                                .data![index]['countryInfo']
                                            ['flag']), // Display country flag
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          // Return an empty container if the country does not match the search query
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
