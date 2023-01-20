import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:Ummah2U/models/autocomplate_prediction.dart';
import 'package:Ummah2U/models/place_auto_complate_response.dart';
import 'package:places_service/places_service.dart';
import 'package:http/http.dart';
import 'components/network_utility.dart';
import 'components/location_list_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void placeAutocomplete(String query) async {
    // Set up request for google places
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json", //unencoder path
      {
        "input": query, //query
        "key": "AIzaSyBkSmy-QRZ5a8H1OHtntJ8ON_vlRsakSrE"
      },
    );

    // Send request
    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);

      if (result != null) {
        setState(() {
          predictions = result.predictions!;
        });
      }
    }
  }

  List<AutocompletePrediction> predictions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) => placeAutocomplete(value),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: predictions.length,
              itemBuilder: (context, index) => LocationListTile(
                location: predictions[index].description!,
                press: () {
                  print("I have been pressed");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

        //  Autocomplete<String>(
        //     optionsBuilder: ((textEditingValue) {
        //       placeAutocomplete("Halal");
        //       if (textEditingValue.text == "") {
        //         return const Iterable<String>.empty();
        //       }
        //       return predictions.where((item) {
        //         return item.contains(textEditingValue.text.toLowerCase());
        //       });
        //     }),
        //     onSelected: (item) {
        //       // ignore: avoid_print
        //       print('The $item was selected!');
        //     },
        //   )