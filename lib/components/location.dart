import 'dart:ffi';

class Location {
  String address;
  String? city;
  String? postalCode;
  String? country;
  double latitude;
  double longitude;
  String? type;

  Location(this.latitude, this.longitude, this.address);
}
