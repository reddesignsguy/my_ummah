import 'package:Ummah2U/components/business.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'package:flutter/material.dart';

// Stateful map page
class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.filter});
  final String filter;

  @override
  State<MapPage> createState() => MapWidget();
}

class MapWidget extends State<MapPage> {
  OverlayEntry? entry;
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    final muslimBusinesses = await getBusinesses();
    print("Creating markers for " +
        muslimBusinesses.length.toString() +
        " businesses");
    setState(
      () {
        _markers.clear();
        for (final business in muslimBusinesses) {
          final marker = Marker(
            markerId: MarkerId(business.name),
            position: LatLng(business.location.latitude.toDouble(),
                business.location.longitude.toDouble()),
            infoWindow: InfoWindow(title: business.name),
            onTap: () {
              //When pressing on a marker
              hideOverlay(); //Clear any previous buttons that were still on screen
              showOverlay(
                  business.name, business.name); //Then draw a new button
            },
          );
          _markers[business.name] = marker;
          print("Created marker for " + business.name);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            hideOverlay();
            Navigator.maybePop(context);
          },
        ),
        centerTitle: true,
        title: Text(widget.filter),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers.values.toSet(),
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        onTap: (argument) {
          hideOverlay();
        },
      ),
    );
  }

  showOverlay(String name, String address) {
    double buttonLeftSpacing = 20;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: buttonLeftSpacing,
        top: MediaQuery.of(context).size.height - 220,
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width - (buttonLeftSpacing * 2),
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              overlayColor: MaterialStatePropertyAll(Colors.green),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/food.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      alignment: const AlignmentDirectional(0, 150),
                      child: Column(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            address,
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    final overlay = Overlay.of(context);
    overlay.insert(entry!);
  }

  hideOverlay() {
    entry?.remove();
    entry = null;
  }
}
