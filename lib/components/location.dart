import 'dart:ffi';

class Location {
  String address;
  String city;
  String postalCode;
  String country;
  Float latitude;
  Float longitude;
  String type;

  Location(this.address, this.city, this.postalCode, this.country,
      this.latitude, this.longitude, this.type);
}
