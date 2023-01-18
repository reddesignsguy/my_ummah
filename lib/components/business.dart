import 'dart:ffi';

import 'package:my_ummah/components/location.dart';

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
