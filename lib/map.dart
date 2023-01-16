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
    setState(
      () {
        _markers.clear();
        for (final office in googleOffices.offices) {
          final marker = Marker(
            markerId: MarkerId(office.name),
            position: LatLng(office.lat, office.lng),
            infoWindow: InfoWindow(
              title: office.name,
              snippet: office.address,
            ),
            onTap: () {
              //When pressing on a marker
              hideOverlay(); //Clear any previous buttons that were still on screen
              showOverlay(office.name, office.address); //Then draw a new button
            },
          );
          _markers[office.name] = marker;
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
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 20,
        top: MediaQuery.of(context).size.height - 200,
        child: SizedBox(
          height: 120,
          width: 300,
          child: ElevatedButton.icon(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black),
            ),
            icon: const Icon(Icons.abc),
            onPressed: () {},
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [Text(name), Text(address)],
              ),
            ),
          ),
        ),
      ),
    );
    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }

  hideOverlay() {
    entry?.remove();
    entry = null;
  }
}
