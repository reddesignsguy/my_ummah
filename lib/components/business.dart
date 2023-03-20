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

Future<List<Business>?> getBusinesses() async {
  List<Business> retval = [];
  var db = FirebaseFirestore.instance;
  await db.collection("businesses").get().then((event) {
    for (var doc in event.docs) {
      //Business temp = Business(doc.id, doc.get(location), phoneNo, email, rating, owner, website);
      //retval.add(temp);
      print("${doc.id} => ${doc.data()}");
    }
  });
  return retval;
}
