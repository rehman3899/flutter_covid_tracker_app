import 'dart:convert'; // Import for JSON encoding and decoding

import 'package:flutter_covid_tracker/models/world_states_model.dart'; // Import the WorldStatesModel class
import 'package:flutter_covid_tracker/services/utils/app_url.dart'; // Import URL configurations
import 'package:http/http.dart' as http; // Import HTTP package for making network requests

// Service class to handle fetching data from APIs
class StatesServices {
  // Method to fetch world states records from the API
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    // Make an HTTP GET request to the world states API
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    // Check if the response status code indicates success
    if (response.statusCode == 200) {
      // Decode the JSON response body into a Map
      var data = jsonDecode(response.body);
      // Convert the Map into a WorldStatesModel object and return it
      return WorldStatesModel.fromJson(data);
    } else {
      // Throw an exception if the response status code indicates failure
      throw Exception('Error');
    }
  }

  // Method to fetch the list of countries from the API
  Future<List<dynamic>> fetchCountriesListRecords() async {
    // Make an HTTP GET request to the countries list API
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    // Declare a variable to hold the response data
    // ignore: prefer_typing_uninitialized_variables
    var data;

    // Check if the response status code indicates success
    if (response.statusCode == 200) {
      // Decode the JSON response body into a List
      data = jsonDecode(response.body);
      // Return the list of countries
      return data;
    } else {
      // Throw an exception if the response status code indicates failure
      throw Exception('Error');
    }
  }
}
