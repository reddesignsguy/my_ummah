import 'dart:collection';

import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:Ummah2U/models/autocomplate_prediction.dart';
import 'package:Ummah2U/models/place_auto_complate_response.dart';
import 'package:places_service/places_service.dart';
import 'package:http/http.dart';
import 'components/network_utility.dart';
import 'components/location_list_tile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Ummah2U/components/algolia_utility.dart';

CollectionReference businesses =
    FirebaseFirestore.instance.collection('businesses');

Algolia algolia = Algolia_Utility.algolia;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void placeAutocomplete(String keyword) async {
    // TO-DO: If query is empty, display search history
    if (keyword == "") {
      setState(() {
        predictions = [];
      });
      return;
    }

    String coord =
        "37.66655556367893, -121.86860258689975"; // TO-DO: REMOVE, IMPLEMENT MOBILE GEOLOCATION

    // Make query
    AlgoliaQuery query = algolia.instance
        .index("businesses")
        .query(keyword)
        .setLength(10)
        .setAroundLatLng(coord);

    // Get result
    AlgoliaQuerySnapshot snap = await query.getObjects();

    // Parse result to map
    var results = snap.toMap();

    // Display predictions
    setState(() {
      predictions = results["hits"];
    });
  }

  List<dynamic> predictions = [];

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
                name: predictions[index]["name"],
                location: predictions[index]["address"],
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
