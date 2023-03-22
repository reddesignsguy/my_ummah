import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Ummah2U/components/location.dart';

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
}

Future<List<Business>> getBusinesses() async {
  List<Business> retval = [];
  print("getBusinesses() called");
  var db = FirebaseFirestore.instance;
  await db.collection("businesses").get().then((event) async {
    //print all the documents in the collection
    for (var doc in event.docs) {
      //Print document number
      print("Document number " + doc.id);
      //create a business object and store a reference to it in retval
      retval.add(Business(
          doc.data()["name"],
          Location(doc.data()["_geoloc"]["lat"], doc.data()["_geoloc"]["lng"]),
          doc.data()["phoneNo"],
          doc.data()["email"],
          doc.data()["rating"],
          doc.data()["owner"],
          doc.data()["website"]));
      print(retval);
    }
  });
  //print the list of businesses
  print("Objects grabbed from database:");
  print(retval);
  return retval;
}
