import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Ummah2U/components/location.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class Business {
  String name;
  Location location;
  String phoneNo;
  String email;
  Float rating;
  String owner;
  String website;

  Business(this.name, this.location, this.phoneNo, this.email, this.rating,
      this.owner, this.website);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': location.latitude,
      'lng': location.longitude,
      'phoneNo': phoneNo,
      'email': email,
      'rating': rating,
      'owner': owner,
      'website': website
    };
  }
}

Future<List<Business>> getBusinesses() async {
  List<Business> retval = [];
  var db = FirebaseFirestore.instance;
  await db.collection("businesses").get().then((event) async {
    for (var doc in event.docs) {
      //create a business object and store a reference to it in retval
      retval.add(Business(
          doc.data()["name"],
          Location(doc.data()["_geoloc"]["lat"], doc.data()["_geoloc"]["lng"]),
          doc.data()["phoneNo"],
          doc.data()["email"],
          doc.data()["rating"],
          doc.data()["owner"],
          doc.data()["website"]));
    }
  });
  writeBusinesses(retval);
  return retval;
}

//take a list of businesses and write them to a json file
Future<void> writeBusinesses(List<Business> businesses) async {
  final directory = await getApplicationDocumentsDirectory();
  String path = "${directory.path}\\assets\\businesses.json";
  for (var business in businesses) {
    final jsonData = jsonEncode(business.toJson());
    File(path).writeAsStringSync(jsonData);
  }
  print("Write Complete");
}
